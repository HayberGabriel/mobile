import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/models/address.dart';
import 'package:lojavirtual/models/cart_manager.dart';
import 'package:lojavirtual/models/cart_product.dart';

enum Status { canceled, preparing, transporting, delivered }

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    userPhone = cartManager.user.telefone;
    status = Status.preparing;
    userName = cartManager.user.name;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.documentID;
    items = (doc.data['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();
    price = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    date = doc.data['date'] as Timestamp;
    userPhone = doc.data['userPhone'] as String;
    status = Status.values[doc.data['status'] as int];
    userName = doc.data['userName'] as String;
  }

  DocumentReference get firestoreRef =>
      Firestore.instance.collection('orders').document(orderId);

  void updateFromDocument(DocumentSnapshot doc) {
    status = Status.values[doc.data['status'] as int];
  }

  Future<void> save() async {
    Firestore.instance.collection('orders').document(orderId).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'userPhone': userPhone,
      'user': userId,
      'userName': userName,
      'status': status.index,
      'date': Timestamp.now(),
    });
  }

  Function() get back {
    return status.index >= Status.transporting.index
        ? () {
            status = Status.values[status.index - 1];
            firestoreRef.updateData({'status': status.index});
          }
        : null;
  }

  Function() get advance {
    return status.index <= Status.transporting.index
        ? () {
            status = Status.values[status.index + 1];
            firestoreRef.updateData({'status': status.index});
          }
        : null;
  }

/*
  Future<void> cancel() async {
    try {
      await CieloPayment().cancel(payId);

      status = Status.canceled;
      firestoreRef.updateData({'status': status.index});
    } catch (e){
      debugPrint('Erro ao cancelar');
      return Future.error('Falha ao cancelar');
    }
  }
*/
  void cancel() {
    status = Status.canceled;
    firestoreRef.updateData({'status': status.index});
  }

  String orderId;
  String payId;

  List<CartProduct> items;
  num price;

  String userId;
  String userName;
  String userPhone;
  Address address;

  Status status;

  Timestamp date;

  String get formattedId => 'Pedido nº ${orderId.padLeft(3, '0')}';

  String get statusText => getStatusText(status);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, userId: $userId, address: $address, date: $date}';
  }
}
