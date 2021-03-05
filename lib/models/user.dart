import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lojavirtual/models/address.dart';

class User {

  User({this.email, this.password, this.name, this.id, this.telefone});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    telefone = document.data['telefone'] as String;
    if(document.data.containsKey('address')){
      address = Address.fromMap(
          document.data['address'] as Map<String, dynamic>);
    }
  }

  String id;
  String name;
  String email;
  String telefone;
  String cpf;
  String password;

  String confirmPassword;



  bool admin = false;

  Address address;

  DocumentReference get firestoreRef =>
    Firestore.instance.document('users/$id');

  CollectionReference get favoriteReference =>
   firestoreRef.collection('favorites');

  CollectionReference get cartReference =>
    firestoreRef.collection('cart');

  CollectionReference get tokensReference =>
      firestoreRef.collection('tokens');



  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'telefone': telefone,
      if(address != null)
        'address': address.toMap(),
      if(cpf != null)
        'cpf': cpf
    };
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }

  void setCpf(String cpf){
    this.cpf = cpf;
    saveData();
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging().getToken();
    await tokensReference.document(token).setData({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }
}