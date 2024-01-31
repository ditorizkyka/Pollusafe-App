import 'package:flutter/material.dart';
import 'pages/main_Pages.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MainRouting());
}

class MainRouting extends StatelessWidget {
  const MainRouting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/loginpage",
      routes: {
        "/loginpage": (context) => const LoginPage(),
        "/mainpage": (context) => const MainPage(),
      },
    );
  }
}

