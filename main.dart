import 'dart:async';
import 'loginPage.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  startTimer() {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }
  route() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context)=>loginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              Image.asset('assets/splash.png', height: 200.0,),

              SizedBox(height: 10.0,),

              Text("Manage your medical adherence here", style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),),
              SizedBox(height: 10.0,),

            ],
          ),)
    );
  }

}


