import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:live_news_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 9, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LIVE NEWS"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    child: Text("data"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        text: "Rubi Gusai",
                      ),
                      Tab(
                        text: "Ana Patel",
                      ),
                      Tab(
                        text: "Shubham Pandya",
                      ),
                      Tab(
                        text: "Rubi Gusai",
                      ),
                      Tab(
                        text: "Ana Patel",
                      ),
                      Tab(
                        text: "Shubham Pandya",
                      ),
                      Tab(
                        text: "Rubi Gusai",
                      ),
                      Tab(
                        text: "Ana Patel",
                      ),
                    ],
                    labelColor: Colors.black,
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        child: allNews(),
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.amber,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.amber,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.amber,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

class allNews extends StatefulWidget {
  const allNews({super.key});

  @override
  State<allNews> createState() => _allNewsState();
}

class _allNewsState extends State<allNews> {
  List<dynamic> all_news = [];
  List<dynamic> automobile_news = [];
  List<dynamic> business_news = [];
  List<dynamic> entertainment_news = [];
  List<dynamic> national_news = [];
  List<dynamic> politics_news = [];
  List<dynamic> science_news = [];
  List<dynamic> sports_news = [];
  List<dynamic> startup_news = [];
  List<dynamic> technology_news = [];
  List<dynamic> world_news = [];

  void getNews() async {
    http.Response all_response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=all"));
    http.Response automobile_response = await http.get(
        Uri.parse("https://inshortsapi.vercel.app/news?category=automobile"));
    http.Response business_response = await http.get(
        Uri.parse("https://inshortsapi.vercel.app/news?category=business"));
    http.Response entertainment_response = await http.get(Uri.parse(
        "https://inshortsapi.vercel.app/news?category=entertainment"));
    http.Response national_response = await http.get(
        Uri.parse("https://inshortsapi.vercel.app/news?category=national"));
    http.Response politics_response = await http.get(
        Uri.parse("https://inshortsapi.vercel.app/news?category=politics"));
    http.Response science_response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=science"));
    http.Response sports_response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=sports"));
    http.Response startup_response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=startup"));
    http.Response technology_response = await http.get(
        Uri.parse("https://inshortsapi.vercel.app/news?category=technology"));
    http.Response world_response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=world"));
    setState(() {
      all_news = json.decode(all_response.body)["data"];
      automobile_news = json.decode(automobile_response.body)["data"];
      business_news = json.decode(business_response.body)["data"];
      entertainment_news = json.decode(entertainment_response.body)["data"];
      national_news = json.decode(national_response.body)["data"];
      politics_news = json.decode(politics_response.body)["data"];
      science_news = json.decode(science_response.body)["data"];
      sports_news = json.decode(sports_response.body)["data"];
      startup_news = json.decode(startup_response.body)["data"];
      technology_news = json.decode(technology_response.body)["data"];
      world_news = json.decode(world_response.body)["data"];
    });
  }

  void initState() {
    super.initState();

    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
