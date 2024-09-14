// ignore_for_file: non_constant_identifier_names, file_names, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
          title: Padding(
            padding: const EdgeInsets.only(right: 18.0, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 2,
                ),
                Text(
                  currentDate,
                  style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Gupter',
                      fontWeight: FontWeight.w100),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentDay.toUpperCase(),
                      style: TextStyle(
                        height: 1,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Gupter',
                      ),
                    ),
                    Text(
                      currentMonth,
                      style: TextStyle(
                          fontSize: 18, height: 0.5, fontFamily: 'Gupter'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          toolbarHeight: 65,
          actions: [
            GestureDetector(
              onTap: () {
                print("Cerebral Logo Tapped");
              },
              child: Image.asset(
                "assets/images/cerebral_logo.png",
                width: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: LiquidPullToRefresh(
          onRefresh: () {
            return Future.delayed(Durations.short4);
          },
          height: sHeight * 0.15,
          animSpeedFactor: 3,
          showChildOpacityTransition: true,
          color: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 30, 30, 30),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: sHeight * 0.892,
                width: sWidth,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      width: sWidth,
                      height: 300,
                      child: Scrollbar(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: all_news.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 20, sigmaY: 25),
                                          child: Dialog(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        228, 226, 221, 01.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                height: sHeight * 0.85,
                                                child: Scrollbar(
                                                  radius: Radius.circular(25),
                                                  child: ListView(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 11),
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    children: [
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Image.asset(
                                                        "assets/images/cerebral_logo.png",
                                                        height: 25,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          all_news[i]
                                                              ["imageUrl"],
                                                          height: sHeight * 0.3,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            all_news[i]["date"],
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          Text("•"),
                                                          Row(
                                                            children: [
                                                              Text(all_news[i]
                                                                  ["time"]),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                        all_news[i]['title'],
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    37,
                                                                    37),
                                                            fontFamily:
                                                                'IBM_Plex_Serif',
                                                            letterSpacing: 0.6,
                                                            height: 1.1,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          3),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25)),
                                                              child: Text(
                                                                "HEADLINE",
                                                                style:
                                                                    TextStyle(
                                                                  letterSpacing:
                                                                      1.5,
                                                                  fontSize: 10,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          228,
                                                                          226,
                                                                          221,
                                                                          01.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "by ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .account_circle_sharp,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                                size: 20,
                                                              ),
                                                              Text(" "),
                                                              Text(
                                                                all_news[i]
                                                                    ["author"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        all_news[i]['content'],
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color:
                                                                Color
                                                                    .fromARGB(
                                                                        255,
                                                                        74,
                                                                        74,
                                                                        74),
                                                            fontFamily:
                                                                'Okine_sans',
                                                            letterSpacing: 0.6,
                                                            height: 1.5,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
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
                                              Colors.white.withOpacity(0.11),
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
                                            letterSpacing: 0.8,
                                            height: 1,
                                            fontSize: 28,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    tabBar(),
                    Expanded(child: tabNews())
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget tabNews() {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;
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
                  physics: BouncingScrollPhysics(),
                  itemCount: sports_news.length,
                  itemBuilder: (context, i) {
                    return Ink(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                  child: Dialog(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                228, 226, 221, 01.0),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        height: sHeight * 0.85,
                                        child: Scrollbar(
                                          radius: Radius.circular(25),
                                          child: ListView(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 11),
                                            physics: BouncingScrollPhysics(),
                                            children: [
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Image.asset(
                                                "assets/images/cerebral_logo.png",
                                                height: 25,
                                                fit: BoxFit.fitHeight,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  sports_news[i]["imageUrl"],
                                                  height: sHeight * 0.3,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    sports_news[i]["date"],
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  Text("•"),
                                                  Row(
                                                    children: [
                                                      Text(sports_news[i]
                                                          ["time"]),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                sports_news[i]['title'],
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 37, 37, 37),
                                                    fontFamily:
                                                        'IBM_Plex_Serif',
                                                    letterSpacing: 0.6,
                                                    height: 1.1,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Text(
                                                        "HEADLINE",
                                                        style: TextStyle(
                                                          letterSpacing: 1.5,
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              228,
                                                              226,
                                                              221,
                                                              01.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "by ",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey.shade600),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .account_circle_sharp,
                                                        color: Colors
                                                            .grey.shade600,
                                                        size: 20,
                                                      ),
                                                      Text(" "),
                                                      Text(
                                                        sports_news[i]
                                                            ["author"],
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey.shade600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                sports_news[i]['content'],
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 74, 74, 74),
                                                    fontFamily: 'Okine_sans',
                                                    letterSpacing: 0.6,
                                                    height: 1.5,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        ),
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
                  physics: BouncingScrollPhysics(),
                  itemCount: national_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                national_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  national_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(national_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              national_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "HEADLINE",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      national_news[i]
                                                          ["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              national_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                  physics: BouncingScrollPhysics(),
                  itemCount: business_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                business_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  business_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(business_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              business_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "business",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      business_news[i]
                                                          ["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              business_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      business_news[i]["title"],
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
                                          business_news[i]["author"],
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
                                  business_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // World News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: world_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                world_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  world_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(world_news[i]["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              world_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "world",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      world_news[i]["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              world_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      world_news[i]["title"],
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
                                          world_news[i]["author"],
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
                                  world_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // Technology News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: technology_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                technology_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  technology_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(technology_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              technology_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "technology",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      technology_news[i]
                                                          ["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              technology_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      technology_news[i]["title"],
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
                                          technology_news[i]["author"],
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
                                  technology_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // Automobile News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: automobile_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                automobile_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  automobile_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(automobile_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              automobile_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "automobile",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      automobile_news[i]
                                                          ["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              automobile_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      automobile_news[i]["title"],
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
                                          automobile_news[i]["author"],
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
                                  world_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // Entertainment News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: entertainment_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                entertainment_news[i]
                                                    ["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  entertainment_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(entertainment_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              entertainment_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "entertainment",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      entertainment_news[i]
                                                          ["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              entertainment_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      entertainment_news[i]["title"],
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
                                          entertainment_news[i]["author"],
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
                                  entertainment_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // Startup News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: startup_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                startup_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  startup_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(startup_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              startup_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "startup",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      startup_news[i]["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              startup_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      startup_news[i]["title"],
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
                                          startup_news[i]["author"],
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
                                  world_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // Science News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: world_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                science_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  science_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(science_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              science_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "science",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      science_news[i]["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              science_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      science_news[i]["title"],
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
                                          science_news[i]["author"],
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
                                  science_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // Politics News
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
                  physics: BouncingScrollPhysics(),
                  itemCount: politics_news.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              228, 226, 221, 01.0),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: sHeight * 0.85,
                                      child: Scrollbar(
                                        radius: Radius.circular(25),
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 11),
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(
                                              "assets/images/cerebral_logo.png",
                                              height: 25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                politics_news[i]["imageUrl"],
                                                height: sHeight * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  politics_news[i]["date"],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Text("•"),
                                                Row(
                                                  children: [
                                                    Text(politics_news[i]
                                                        ["time"]),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              politics_news[i]['title'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 37, 37),
                                                  fontFamily: 'IBM_Plex_Serif',
                                                  letterSpacing: 0.6,
                                                  height: 1.1,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Text(
                                                      "HEADLINE",
                                                      style: TextStyle(
                                                        letterSpacing: 1.5,
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            228,
                                                            226,
                                                            221,
                                                            01.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "by ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      politics_news[i]
                                                          ["author"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              politics_news[i]['content'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  fontFamily: 'Okine_sans',
                                                  letterSpacing: 0.6,
                                                  height: 1.5,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
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
                                      politics_news[i]["title"],
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
                                          politics_news[i]["author"],
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
                                  politics_news[i]["imageUrl"],
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
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
