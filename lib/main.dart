import 'package:flutter/material.dart';


import 'package:news/view/home_screen.dart';
import 'package:news/view/news_details.dart';
import 'package:news/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          elevation:0,
          
          
          color: Colors.white
        )
      ),
      home: HomeScreen()
    );
  }
}


 