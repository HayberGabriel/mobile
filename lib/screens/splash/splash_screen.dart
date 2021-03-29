import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 2), (){
      Navigator.of(context).popAndPushNamed('/home');
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              child: Image.asset("assets/logo.png")
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
            )
          ],
        ),
      ),
    );
  }
}
