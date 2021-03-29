import 'package:flutter/material.dart';
import 'package:lojavirtual/common/order/cancel_order_dialog.dart';
import 'package:lojavirtual/common/order/export_address_dialog.dart';
import 'package:lojavirtual/common/order/order_product_tile.dart';
import 'package:lojavirtual/models/order.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderTile extends StatelessWidget {

  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;

  Future<void> openPhone(String x) async {
    await launch('tel:${x}');
  }

  @override
  Widget build(BuildContext context) {
    Color getcolor(){
      if (order.status == Status.canceled){
        return Colors.red;
      }
      else if(order.status == Status.preparing){
        return Colors.orange;
      }
      else if(order.status == Status.transporting){
        return Colors.lightBlue;
      }
      else{
        return Colors.green;
      }
    }
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: getcolor(),
                fontSize: 14
              ),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e){
              return OrderProductTile(e);
            }).toList(),
          ),
          if(showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => CancelOrderDialog(order)
                      );
                    },
                    textColor: Colors.red,
                    child: const Text('Cancelar'),
                  ),
                  FlatButton(
                    onPressed: order.back,
                    child: const Text('Recuar'),
                  ),
                  FlatButton(
                    onPressed: order.advance,
                    child: const Text('Avançar',
                    style: TextStyle(color: Colors.green),),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {
                      openPhone(order.userPhone);
                    },
                  ),
                  FlatButton(
                    onPressed: (){
                      showDialog(context: context,
                        builder: (_) => ExportAddressDialog(order.address)
                      );
                    },
                    textColor: primaryColor,
                    child: const Text('Endereço'),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
