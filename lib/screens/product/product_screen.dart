import 'dart:ffi';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_manager.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  _ProductScreenState(this.product);

  final Product product;
  bool favorite = false;
  bool notification = false;
  String size;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled && !product.deleted) {
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          '/edit_product',
                          arguments: product);
                    },
                  );
                } else {
                  return IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(
                            'Confira já a ${product.name},a partir de R\$${product.basePrice.toStringAsFixed(2)} '
                            'no app MODA ONLINE,descontos exclusivos',
                            subject: 'Baixe já o nosso app');
                      });
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Stack(children: [
                Carousel(
                  images: product.images.map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 6.0,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: primaryColor,
                  autoplay: false,
                ),
                Container(
                  margin: EdgeInsets.only(left: 260, right: 5, top: 5),
                  height: 50,
                  decoration: BoxDecoration(
                    color: product.hasStock
                        ? Colors.green.withOpacity(0.75)
                        : Colors.red.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                product.hasStock ? 'Disponível' : 'Indisponível',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: product.hasStock ? 25.0 : 22.58),
                ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 27.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'A partir de',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.59),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      'R\$',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${product.basePrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: primaryColor,
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.59),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withAlpha(70))),
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.59),
                        fontWeight: FontWeight.w400),
                  ),
                  if (product.deleted)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Este produto não está mais disponível',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    )
                  else ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        'Tamanhos',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.59),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withAlpha(70))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: product.sizes.map((s) {
                          return SizeWidget(size: s);
                        }).toList(),
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 15,
                  ),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 10 , right: 26),
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        icon: Icon(favorite
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                        color: Colors.black,
                                        iconSize: 42,
                                        onPressed: () {
                                          if (favorite == false) {
                                            final snack = SnackBar(
                                              content: Text(
                                                'Peça adicionada aos favoritos',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: Colors.black,
                                              duration: Duration(seconds: 2),
                                            );
                                            Scaffold.of(context)
                                                .showSnackBar(snack);
                                          } else {
                                            final snack = SnackBar(
                                              content: Text(
                                                'Peça removida dos favoritos',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: Colors.black,
                                              duration: Duration(seconds: 2),
                                            );
                                            Scaffold.of(context)
                                                .showSnackBar(snack);
                                          }
                                          setState(() {
                                            favorite = !favorite;
                                          });
                                        }),
                                  ),
                                );
                              }),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: product.selectedSize != null
                                      ? () {
                                          if (userManager.isLoggedIn) {
                                            context
                                                .read<CartManager>()
                                                .addToCart(product);
                                            Navigator.of(context)
                                                .pushNamed('/cart');
                                          } else {
                                            Navigator.of(context)
                                                .pushNamed('/login');
                                          }
                                        }
                                      : null,
                                  color: primaryColor,
                                  textColor: Colors.white,
                                  child: Text(
                                    userManager.isLoggedIn
                                        ? 'Reservar'
                                        : 'Entre para Comprar',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ]);
                      },
                    )
                  else
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Builder(builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10 , right: 26),
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(notification ? Icons.notifications_active : Icons.notifications_none),
                                color: Colors.black,
                                iconSize: 42,
                                onPressed: () {
                                  if(notification == false){
                                    final snack = SnackBar(content: Text(
                                      'Você será notificado quando a peça estiver disponível',
                                      style: TextStyle(color: Colors.white),),
                                      backgroundColor: Colors.black,
                                      duration: Duration(seconds: 2),
                                    );
                                    Scaffold.of(context).showSnackBar(snack);
                                  }else {
                                    final snack = SnackBar(content: Text(
                                      'Você não será mais notificado',
                                      style: TextStyle(color: Colors.white),),
                                      backgroundColor: Colors.black,
                                      duration: Duration(seconds: 2),
                                    );
                                    Scaffold.of(context).showSnackBar(snack);
                                  }
                                  setState(() {
                                    notification = !notification;
                                  }
                                  );
                                }),
                          ),
                        );}
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: null,
                          child: Text('Indisponível',style: const TextStyle(fontSize: 20),),

                        ),
                      ),
                    ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
