import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlogin_page/pages/account_page.dart';
import 'package:latlogin_page/pages/map_page.dart';
import 'package:latlogin_page/pages/timeline_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexOptions = 0;

  final List<Widget> menuOptions = [
    const TimelinePage(),
    const MapsPage(),
    const AccountPage(),
  ];

  void onMenuTapped(int index) {
    setState(() {
      indexOptions = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Timeline",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Account"),
        ],
        onTap: onMenuTapped ,
      ),
      body: menuOptions[indexOptions],
    ));
  }
}
