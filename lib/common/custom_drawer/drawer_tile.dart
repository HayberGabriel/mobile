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
    final Color primaryColor = Colors.white;

    return Material(
      color: curPage == page ? Colors.black : Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey,
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
                  color: curPage == page ? primaryColor : Colors.black,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: curPage == page ? primaryColor : Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
