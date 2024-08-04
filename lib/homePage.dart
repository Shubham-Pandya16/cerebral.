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
    tabController = TabController(length: 9, vsync: this);

    getNews();
  }

  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromRGBO(241, 239, 231, 01.0),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: IconButton(
                  onPressed: () {
                    print("more in Appbar");
                  },
                  icon: Icon(Icons.more_vert)),
            ),
          ],
          backgroundColor: Color.fromRGBO(241, 239, 231, 01.0),
          centerTitle: true,
          title: Image.asset(
            "assets/images/cerebral_logo.png",
            width: 150,
            fit: BoxFit.fitWidth,
          ),
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
                    height: 200,
                    width: 110,
                    child: Text(
                      "hahh",
                      style: TextStyle(
                        fontFamily: 'Saira Extra Condensed',
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TabBar(
                    isScrollable: true,
                    controller: tabController,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontFamily:
                          'Saira Extra Condensed', // Use the custom font
                      fontSize: 25,
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          "All",
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
