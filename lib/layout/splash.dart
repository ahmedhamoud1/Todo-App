import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(milliseconds: 3200),() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Home() ), (route) => false)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff517fe7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff517fe7),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Image.asset('images/0.PNG')
        ],
      ),
    );
  }
}
