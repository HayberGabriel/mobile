import 'package:flutter/material.dart';
import 'package:lojavirtual/common/empty_card.dart';
import 'package:lojavirtual/common/login_card.dart';
import 'package:lojavirtual/models/favorite_manager.dart';
import 'package:provider/provider.dart';

import 'components/favorite_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: Consumer<FavoriteManager>(
        builder: (_,favoriteManager,__){
          if (favoriteManager.user == null) {
            return LoginCard();
          }

          if (favoriteManager.items.isEmpty) {
            return EmptyCard(
              iconData: Icons.favorite_outlined,
              title: 'Nenhum produto nos favoritos!',
            );
          }

          return Column(
            children: favoriteManager.items.map(
                    (favoriteProduct) => FavoriteTile(favoriteProduct)
            ).toList(),
          );
        },
      ),
    );
  }
}
