import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/view/home_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.height*1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash_pic.jpg",
              fit: BoxFit.cover,
              height: height*0.5,
              ),
              SizedBox(
                height: height*0.04,
              ),
              Text(
                "Top Headlines",
                style:GoogleFonts.anton(
                  letterSpacing: 0.6,
                  color: Colors.grey.shade700
                ),
              ),
              SizedBox(
                height: height*0.04,
              ),
              SpinKitChasingDots(
                size: 40,
                color:Colors.blue ,
              )
            
          ],
        ),
      ),
    );
  }
}