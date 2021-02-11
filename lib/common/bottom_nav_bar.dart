import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:provider/provider.dart';


class BottomNavBar extends StatelessWidget {
  BottomNavBar({this.page});

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BottomNavigationBar(
        currentIndex: page,
        onTap: (page) {
          context.read<PageManager>().setPage(page);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Oi")),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), title: Text("Perfil")),

        ],
      ),
    );
  }
}
