import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/models/favorite_product.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';

class FavoriteManager extends ChangeNotifier{

  List<FavoriteProduct> items = [];

  User user;

  void updateUser(UserManager userManager){
    user = userManager.user;
    items.clear();

    if(user != null){
      _loadFavoriteItems();
    }
  }

 Future<void> _loadFavoriteItems() async{
  final QuerySnapshot favSnap = await user.favoriteReference.getDocuments();
  
  items = favSnap.documents.map(
          (d) => FavoriteProduct.fromDocument(d)..addListener(_onItemUpdated)
  ).toList();
  }

  void addToFavorite(Product product){
    try {
      final e = items.firstWhere((p) => p.stackable(product));
    }catch (e){
      final favoriteProduct = FavoriteProduct.fromProduct(product);
      favoriteProduct.addListener(_onItemUpdated);
      items.add(favoriteProduct);
      user.favoriteReference.add(favoriteProduct.toFavoriteItemMap())
          .then((doc) => favoriteProduct.id = doc.documentID);
    }

  }
  void removeOfFavorite(FavoriteProduct favoriteProduct){
    items.removeWhere((p) => p.id == favoriteProduct.id);
    user.favoriteReference.document(favoriteProduct.id).delete();
    favoriteProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated(){
    for(int i = 0; i<items.length; i++){
      final favoriteProduct = items[i];

      if(favoriteProduct.quantity == 0){
        removeOfFavorite(favoriteProduct);
        i--;
        continue;
      }

      _updateFavoriteProduct(favoriteProduct);
    }
  }

  void _updateFavoriteProduct(FavoriteProduct favoriteProduct){
    user.favoriteReference.document(favoriteProduct.id).updateData(favoriteProduct.toFavoriteItemMap());
  }

}