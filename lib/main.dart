import 'package:flutter/material.dart';
import 'package:live_news_app/homePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.light(), useMaterial3: true),
    home: HomePage(),
  ));
}
