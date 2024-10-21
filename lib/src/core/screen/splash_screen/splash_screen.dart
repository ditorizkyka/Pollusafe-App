import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pollusafe_app/src/constant/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.goNamed("signin");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorApp.green,
      body: Center(
        child: SizedBox(
            width: 200,
            height: 200,
            child: Image(
              image: AssetImage("assets/logo/pollusafe.png"),
            )),
      ),
    );
  }
}
