import 'package:cerebral/coverpage.dart';
import 'package:cerebral/homePage.dart';
import 'package:cerebral/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Color.fromRGBO(228, 226, 221, 01.0)),
        useMaterial3: true),
    home: CoverScreen(),
  ));
}