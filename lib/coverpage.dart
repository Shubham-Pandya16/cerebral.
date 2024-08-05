import 'dart:async';

import 'package:cerebral/homePage.dart';
import 'package:cerebral/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoverScreen extends StatefulWidget {
  const CoverScreen({super.key});

  @override
  State<CoverScreen> createState() => _CoverScreenState();
}

class _CoverScreenState extends State<CoverScreen> {
  @override
  void initState() {
    super.initState();

    starttime();
  }

  starttime() async {
    var duration = Duration(seconds: 40);
    return Timer(duration, nextScreen);
  }

  nextScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(228, 226, 221, 01.0),
        body: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/cerebral_wb.png"),
                ],
              ),
              Container(
                padding: EdgeInsets.all(60),
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/since.png",
                  height: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
