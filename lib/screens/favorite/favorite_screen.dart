import 'package:flutter/material.dart';
import 'package:lojavirtual/common/bottom_nav_bar.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/common/empty_card.dart';
import 'package:lojavirtual/common/login_card.dart';
import 'package:lojavirtual/models/favorite_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/favorite_tile.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: Consumer<FavoriteManager>(
        builder: (_, favoriteManager, __) {
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
            children: favoriteManager.items
                .map((favoriteProduct) => FavoriteTile(favoriteProduct))
                .toList(),
          );
        },
      ),
      bottomNavigationBar: Consumer<UserManager>(
          builder: (_, userManager, __) {
            if (userManager.adminEnabled) {
              return BottomNavBar(page: 0);
            } else {
              return BottomNavBar(page: 0);
            }
          }
      ),
    );
  }
}
