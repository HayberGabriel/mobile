import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = Colors.black;

    return Material(
      child: InkWell(
        onTap: (){
          context.read<PageManager>().setPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Icon(
                    iconData,
                    size: 32,
                    color: curPage == page ? Color.fromARGB(255, 4, 125, 141) : Colors.black
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: curPage == page ? Color.fromARGB(255, 4, 125, 141) : Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
