import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:live_news_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("data"),
        ),
        body: allNews());
  }
}

class allNews extends StatefulWidget {
  const allNews({super.key});

  @override
  State<allNews> createState() => _allNewsState();
}

class _allNewsState extends State<allNews> {
  List<dynamic>? all_news;
  void getNews() async {
    http.Response all_response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=all"));
    List<dynamic> all_data = json.decode(all_response.body)["data"];
    setState(() {
      all_news = all_data;
    });
  }

  void initState() {
    super.initState();

    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          final allnews = all_news![i];
          return Card(
            child: Column(
              children: [
                Image.network(
                  allnews!['imageUrl'],
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Text(allnews!['title'])
              ],
            ),
          );
        });
  }
}
