import 'package:flutter/material.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Map/main.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Profile/main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedidx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          shadowColor: Colors.white,
          elevation: 10,
          indicatorColor: Colors.white,
          backgroundColor: Colors.white,
          selectedIndex: _selectedidx,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedidx = index;
            });
          },
          destinations: [
            const NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Dashboard",
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: NavigationDestination(
                  selectedIcon: Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorApp.green,
                    ),
                    child: const Icon(
                      Icons.map_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  icon: Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorApp.green,
                    ),
                    child: const Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  label: "Map"),
            ),
            const NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_2_outlined),
                label: "Profile"),
          ]),
      body: SafeArea(
          child: IndexedStack(
        index: _selectedidx,
        children: const [
          HomePage(),
          MapPage(),
          ProfilePage(),
        ],
      )),
    );
  }
}
