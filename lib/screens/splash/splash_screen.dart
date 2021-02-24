import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      Duration(seconds: 3), (){
      Navigator.of(context).pushNamed('/home');
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
              child: Image.network('https://pbs.twimg.com/media/EtrK_AXWgAEcZ8m?format=png&name=small'),
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
