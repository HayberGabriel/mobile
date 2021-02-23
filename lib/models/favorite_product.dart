import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/models/product.dart';

class FavoriteProduct extends ChangeNotifier{
  FavoriteProduct.fromProduct(this.product){
    productId = product.id;
    quantity = 1;
  }

  FavoriteProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    quantity = document.data['quantity'] as int;
    productId = document.data['pid'] as String;
    
    firestore.document('products/$productId').get().then(
            (doc) => product = Product.fromDocument(doc)
    );
  }

  final Firestore firestore = Firestore.instance;

  int quantity;
  String id;
  String productId;

  Product product;

  Map<String, dynamic> toFavoriteItemMap(){

    return{
      'pid': productId,
      'quantity': quantity,
    };
  }

  bool stackable(Product product){
    return product.id == productId;
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }
}