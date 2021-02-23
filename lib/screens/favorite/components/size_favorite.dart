import 'package:flutter/material.dart';
import 'package:lojavirtual/models/item_size.dart';

class SizeFavorite extends StatelessWidget {

  SizeFavorite({this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.black
        ),
      ),
      child: Container(
          color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        child:Text(
          size.name,style: TextStyle(color: Colors.white,fontSize: 10),
        ),
      ),
    );
  }
}
