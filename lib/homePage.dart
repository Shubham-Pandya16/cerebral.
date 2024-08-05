// ignore_for_file: non_constant_identifier_names, file_names, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String currentMonth = DateFormat.MMMM().format(DateTime.now());
String currentYear = DateFormat.y().format(DateTime.now());
String currentDate = DateFormat.d().format(DateTime.now());
String currentDay = DateFormat.EEEE().format(DateTime.now());

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;

  late TabController tabController;

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
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 10, vsync: this);

    getNews();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Gothic text font to be used for news headlines
  // Roboto for articles
  // showDialog for displaying full article

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 226, 221, 01.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(228, 226, 221, 01.0),
          surfaceTintColor: Colors.transparent,
          title: GestureDetector(
            onTap: () {
              print("Cerebral Logo Tapped");
            },
            child: Image.asset(
              "assets/images/cerebral_logo.png",
              width: 150,
              fit: BoxFit.fitWidth,
            ),
          ),
          toolbarHeight: 65,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 2),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currentDay.toUpperCase(),
                        style: TextStyle(
                          height: 1,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gupter',
                        ),
                      ),
                      Text(
                        currentMonth,
                        style: TextStyle(
                            fontSize: 16, height: 0.5, fontFamily: 'Gupter'),
                      ),
                    ],
                  ),
                  Text(
                    currentDate,
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Gupter',
                        fontWeight: FontWeight.w100),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: sHeight,
              width: sWidth,
              child: Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    width: sWidth,
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: all_news.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10),
                          child: Stack(
                            children: [
                              Container(
                                child: Center(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    all_news[i]["imageUrl"],
                                    height: double.infinity,
                                    width: sWidth * 0.9,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: double.infinity,
                                width: sWidth * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.99),
                                        Colors.black.withOpacity(0.65),
                                        Colors.black.withOpacity(0.25),
                                        Colors.white.withOpacity(0.11)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.bottomLeft,
                                height: double.infinity,
                                width: sWidth * 0.9,
                                child: Text(
                                  all_news[i]['title'].toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'Saira Extra Condensed',
                                      letterSpacing: 0.5,
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  tabBar(),
                  Expanded(child: tabNews())
                ],
              ),
            ),
          ),
        ));
  }

  Widget tabNews() {
    return TabBarView(
      controller: tabController,
      children: [
        Container(
          // Sports News
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 1,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: sports_news.length,
                  itemBuilder: (context, i) {
                    return Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sports_news[i]["title"],
                                    style: TextStyle(
                                      fontFamily: 'IBM Plex Serif',
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.3,
                                      fontSize: 15,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "by ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600),
                                      ),
                                      Icon(
                                        Icons.account_circle_sharp,
                                        color: Colors.grey.shade600,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        sports_news[i]["author"],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                sports_news[i]["imageUrl"],
                                width: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      endIndent: 25,
                      indent: 25,
                    );
                  },
                ),
        ),
        Container(
          // National News
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 1,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: national_news.length,
                  itemBuilder: (context, i) {
                    return Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    national_news[i]["title"],
                                    style: TextStyle(
                                      fontFamily: 'IBM Plex Serif',
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.3,
                                      fontSize: 15,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "by ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600),
                                      ),
                                      Icon(
                                        Icons.account_circle_sharp,
                                        color: Colors.grey.shade600,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        national_news[i]["author"],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                national_news[i]["imageUrl"],
                                width: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      endIndent: 25,
                      indent: 25,
                    );
                  },
                ),
        ),
        Container(
          // Business News
          color: Colors.red,
        ),
        Container(
          // World News
          color: Colors.amber,
        ),
        Container(
          // Technology News
          color: Colors.blue,
        ),
        Container(
          // Automobile News
          color: Colors.red,
        ),
        Container(
          // Entertainment News
          color: Colors.amber,
        ),
        Container(
          // Startup News
          color: Colors.blue,
        ),
        Container(
          // Science News
          color: Colors.redAccent,
        ),
        Container(
          // Politics News
          color: Colors.amber,
        ),
      ],
    );
  }

  TabBar tabBar() {
    return TabBar(
      isScrollable: true,
      controller: tabController,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(
          fontFamily: 'Saira Extra Condensed', // Use the custom font
          fontSize: 25,
          fontWeight: FontWeight.w900),
      tabs: [
        Tab(
          text: "Sports",
          icon: Icon(Icons.sports_volleyball),
        ),
        Tab(
          text: "National",
          icon: Icon(Icons.flag_circle_sharp),
        ),
        Tab(
          text: "Business",
          icon: Icon(Icons.attach_money),
        ),
        Tab(
          text: "World",
          icon: Icon(Icons.airplane_ticket_outlined),
        ),
        Tab(
          text: "Technology",
          icon: Icon(Icons.phonelink_outlined),
        ),
        Tab(
          text: "Automobile",
          icon: Icon(Icons.speed),
        ),
        Tab(
          text: "Entertainment",
          icon: Icon(Icons.hourglass_empty_rounded),
        ),
        Tab(
          text: "Startup",
          icon: Icon(Icons.add_business_outlined),
        ),
        Tab(
          text: "Science",
          icon: Icon(Icons.biotech_outlined),
        ),
        Tab(
          text: "Politics",
          icon: Icon(Icons.people_alt_outlined),
        ),
      ],
      labelColor: Colors.black,
    );
  }
}
