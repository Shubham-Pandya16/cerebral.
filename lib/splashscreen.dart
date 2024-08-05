import 'dart:async';

import 'package:cerebral/coverpage.dart';
import 'package:cerebral/homePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    starttime();
  }

  starttime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, nextScreen);
  }

  nextScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: sHeight,
          width: sWidth,
          color: Color.fromRGBO(241, 239, 231, 01.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/images/news_loading.json",
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
