import 'package:cerebral/coverpage.dart';
import 'package:cerebral/homePage.dart';
import 'package:cerebral/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true),
    home: CoverScreen(),
  ));
}
