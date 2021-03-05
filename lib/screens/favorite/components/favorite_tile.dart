import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_icon_button.dart';
import 'package:lojavirtual/models/favorite_product.dart';
import 'package:lojavirtual/screens/favorite/components/size_favorite.dart';
import 'package:provider/provider.dart';

class FavoriteTile extends StatelessWidget {

  const FavoriteTile(this.favoriteProduct);

  final FavoriteProduct favoriteProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: favoriteProduct,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(
              '/product',
              arguments: favoriteProduct.product);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(favoriteProduct.product.images.first),
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favoriteProduct.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Text(
                                    'A partir de',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.59),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                Text(
                                  'R\$ ${favoriteProduct.product.basePrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if(favoriteProduct.product.hasStock)
                          Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: favoriteProduct.product.sizes.map((s){
                                return SizeFavorite(size: s);
                              }).toList(),
                            ),
                          ),
                          if(!favoriteProduct.product.hasStock)
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                'Sem estoque',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                ),
                Column(
                  children: [
                    CustomIconButton(
                      iconData: Icons.favorite,
                      color: Colors.redAccent,
                      onTap: favoriteProduct.decrement,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
