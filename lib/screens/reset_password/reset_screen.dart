import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redefinir Senha'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Verifique seu email!',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const  EdgeInsets.all(15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ Text('Enviaremos um pedido de redefinição de senha para você!',
                  ),
                ]
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Digite seu Email',
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value){
                setState(() {
                  _email = value;
                });
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          RaisedButton(onPressed: (){
            auth.sendPasswordResetEmail(email: _email);
            Navigator.of(context).pop();
          },
            color: Theme.of(context).primaryColor,
            child: Text('Enviar Pedido'),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
