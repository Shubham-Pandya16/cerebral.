import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Get the current month name
    String currentMonth = DateFormat.MMMM().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Current Month Example'),
      ),
      body: Center(
        child: Text(
          'Current Month: $currentMonth',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
