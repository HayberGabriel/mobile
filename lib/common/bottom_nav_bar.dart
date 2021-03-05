import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.page});

  int page = 0;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    return Material(child: Consumer<UserManager>(builder: (_, userManager, __) {
      if (userManager.adminEnabled) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.page,
          onTap: (page) {
            context.read<PageManager>().setPage(page);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: curPage == 0
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
                title: Text(
                  "Início",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: curPage == 0
                          ? Color.fromARGB(255, 4, 125, 141)
                          : Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.list,
                    color: curPage == 1
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
                title: Text(
                  "Produtos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: curPage == 1
                          ? Color.fromARGB(255, 4, 125, 141)
                          : Colors.black),
                )),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: curPage == 2
                      ? Color.fromARGB(255, 4, 125, 141)
                      : Colors.black),
              title: Text(
                "Usuários",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: curPage == 2
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt,
                  color: curPage == 3
                      ? Color.fromARGB(255, 4, 125, 141)
                      : Colors.black),
              title: Text(
                "Pedidos",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: curPage == 3
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
              ),
            ),
          ],
        );
      } else {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.page,
          onTap: (page) {
            context.read<PageManager>().setPage(page);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: curPage == 0
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
                title: Text(
                  "Início",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: curPage == 0
                          ? Color.fromARGB(255, 4, 125, 141)
                          : Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.list,
                    color: curPage == 1
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
                title: Text(
                  "Produtos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: curPage == 1
                          ? Color.fromARGB(255, 4, 125, 141)
                          : Colors.black),
                )),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check,
                  color: curPage == 2
                      ? Color.fromARGB(255, 4, 125, 141)
                      : Colors.black),
              title: Text(
                "Meus Pedidos",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: curPage == 2
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store,
                  color: curPage == 3
                      ? Color.fromARGB(255, 4, 125, 141)
                      : Colors.black),
              title: Text(
                "Lojas",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: curPage == 3
                        ? Color.fromARGB(255, 4, 125, 141)
                        : Colors.black),
              ),
            ),
          ],
        );
      }
    }));
  }
}
