import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/core/controller/UserController.dart';

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
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // ignore: use_build_context_synchronously
        final userController = Get.put(UserController());
        userController.userData();
        context.goNamed("dashboard");
      } else {
        context.goNamed("signin");
      }
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
