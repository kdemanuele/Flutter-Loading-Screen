import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:clounce_loading_screen/loading_screen.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Loading Screen Example',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: LoadingScreenExample(),
    );
  }
}

class LoadingScreenExample extends StatefulWidget {
  @override
  LoadingScreenExampleState createState() => LoadingScreenExampleState();
}

class LoadingScreenExampleState extends State<LoadingScreenExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingScreen(
      initializers: <dynamic>[TimeMessages.timer],
      navigateToWidget: Scaffold(
        appBar: AppBar(
          title: Text('Done'),
        ),
      ),
      loaderColor: Colors.white,
      image: Image.asset('assets/lake.jpg', fit: BoxFit.cover,),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent),
    ));
  }
}

class TimeMessages {
  static Future timer(MessageState state) async {
    while (true) {
      await Future.delayed(Duration(seconds: 5), () {
        state.setMessage = DateTime.now().toIso8601String();
      });
    }
  }
}
