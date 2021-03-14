import 'package:flutter/material.dart';
import 'package:lojavirtual/common/order/order_product_tile.dart';
import 'package:lojavirtual/models/order.dart';


class ConfirmationScreen extends StatelessWidget {

  const ConfirmationScreen(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação de Pedido'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      order.formattedId,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'Total: R\$ ${order.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: order.items.map((e){
                  return OrderProductTile(e);
                }).toList(),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.black,
                child: Text('Confirmar Pedido', style: TextStyle(fontSize: 18, color: Colors.white),),
                onPressed: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: Text('Pedido Confirmado!'),
                      content: Text('Acompanhe seu pedido na aba Meus Pedidos.'),
                      actions: [
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: (){
                            Navigator.of(context).popAndPushNamed('/home');
                          },
                        ),

                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}









/*AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Text('Seu pedido foi confirmado!'),
                          Text('Acompanhe o progresso do pedido em Meus Pedidos'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(child: Text('Ok'),
                        onPressed: (){
                        Navigator.of(context).pop();
                      },
                      )
                    ],
                  );*/