// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // Get the current month name
//     String currentMonth = DateFormat.MMMM().format(DateTime.now());

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Current Month Example'),
//       ),
//       body: Center(
//         child: Text(
//           'Current Month: $currentMonth',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: non_constant_identifier_names, file_names, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isLoading = true;

  late TabController tabController;

  List<dynamic> sports_news = [];

  void getNews() async {
    http.Response sports_response = await http.get(Uri.parse("https://inshortsapi.vercel.app/news?category=sports"));
    setState(() {
      sports_news = json.decode(sports_response.body)["data"];
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

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 239, 231, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 239, 231, 1.0),
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
        actions: [
          Container(
            height: 45,
            width: 20,
            color: Colors.amber,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: sWidth,
              height: 250,
              color: Colors.grey[200],
              // Zomato like Card View for main headlines along with stack
            ),
            tabBar(),
            Expanded(child: tabNews()),
          ],
        ),
      ),
    );
  }

  Widget tabNews() {
    return TabBarView(
      controller: tabController,
      children: [
        Container(
          child: isLoading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
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
                                  SizedBox(height: 8),
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
                                      SizedBox(width: 3),
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
        Container(color: Colors.blue),
        Container(color: Colors.red),
        Container(color: Colors.amber),
        Container(color: Colors.blue),
        Container(color: Colors.red),
        Container(color: Colors.amber),
        Container(color: Colors.blue),
        Container(color: Colors.redAccent),
        Container(color: Colors.amber),
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
      ),
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

