import 'package:flutter/material.dart';
import 'package:lojavirtual/models/item_size.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {

  const SizeWidget({this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;
    if(!size.hasStock)
      color = Colors.red.withAlpha(70);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return RaisedButton(
      color: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
      ),
      onPressed: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
      child: Container(

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,),
              ),
            ),
            Container(

              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
              child: Text(
                'R\$${size.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
