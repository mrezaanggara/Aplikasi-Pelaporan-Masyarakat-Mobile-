import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reportin/view/LoginPage.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{

  void initState(){
    super.initState();
    startSplashScreen();
  }

  startSplashScreen () async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/logo_pekon.png',scale: 5,),
              Image.asset('assets/images/logo_unila.png',scale: 20,),
            ],
          ),
          SizedBox(height: 180,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[              
              Image.asset('assets/images/appicon2.png', scale: 3,),
              SizedBox(height: 24.0),
              Text(
                "Aplikasi Pelaporan Masyarakat",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[400]),
              ),
            ],
          ),
          SizedBox(height: 240),
          Text('Copyright © Aplikasi Pelaporan Masyarakat 2022',textAlign: TextAlign.center, style: TextStyle(fontSize: 10),)
        ],
      )
    );
  }
}