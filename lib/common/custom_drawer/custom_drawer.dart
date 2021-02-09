import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer_header.dart';
import 'package:lojavirtual/common/custom_drawer/drawer_tile.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        CustomDrawerHeader(),
        DrawerTile(
          iconData: Icons.home,
          title: 'Início',
          page: 0,
        ),
        DrawerTile(
          iconData: Icons.person_pin,
          title: 'Perfil',
          page: 1,
        ),
        DrawerTile(
          iconData: Icons.list,
          title: 'Produtos',
          page: 2,
        ),
        DrawerTile(
          iconData: Icons.playlist_add_check,
          title: 'Meus Pedidos',
          page: 3,
        ),
        DrawerTile(
          iconData: Icons.store,
          title: 'Lojas',
          page: 4,
        ),
        Consumer<UserManager>(
          builder: (_, userManager, __) {
            if (userManager.adminEnabled) {
              return Column(
                children: <Widget>[
                  DrawerTile(
                    iconData: Icons.person,
                    title: 'Usuários',
                    page: 5,
                  ),
                  DrawerTile(
                    iconData: Icons.list_alt,
                    title: 'Pedidos',
                    page: 6,
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        )
      ],
    ));
  }
}
