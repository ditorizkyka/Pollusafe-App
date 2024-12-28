import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:pollusafe_app/services/auth_services.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/widgets/signup_field.dart';

import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  void createAccount() async {
    // Implementasi logika untuk membuat akun
    String? res = await AuthServices().signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nicknameController.text);

    if (res == '200 OK') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialogApp(
            title: "Success",
            description: "Your account has been created successfully.",
          );
        },
      );

      context.goNamed('dashboard');
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogApp(
            title: "Sign Up failed",
            description: res,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // Membungkus konten dengan SingleChildScrollView untuk menghindari overflow
            padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Create a",
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: ColorApp.darkBlue,
                            )),
                        Text(" Pollusafe",
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: ColorApp.green,
                            )),
                      ],
                    ),
                    Text("account",
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ColorApp.darkBlue,
                        )),
                  ],
                ),
                Gap.h8,
                Text("Welcome back, fill to Sign up your account",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.darkGrey,
                    )),
                Gap.h32,
                SignupField(
                  nicknameController: nicknameController,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                Gap.h8,
                Row(
                  children: [
                    Expanded(
                      child: ButtonApp(
                          onPressed: () {
                            createAccount();
                          },
                          text: "Sign up"),
                    ),
                  ],
                ),
                Gap.h16,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Expanded(child: Divider(color: ColorApp.lightGrey)),
                  const SizedBox(width: 20),
                  Text(
                    "or",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.darkGrey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Expanded(child: Divider(color: ColorApp.lightGrey)),
                ]),
                Gap.h16,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom:
                16), // Menambahkan padding agar tidak terlalu menempel di bawah
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorApp.darkGrey,
              ),
            ),
            TextButton(
              onPressed: () {
                context.goNamed('signin');
              },
              child: Text(
                "Sign in",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AlertDialogApp extends StatelessWidget {
  final String title;
  final String description;
  final bool? unFocus;

  const AlertDialogApp({
    this.unFocus,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorApp.darkBlue,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        description,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorApp.darkGrey,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        ButtonApp(
            onPressed: () {
              if (unFocus == true) {
                FocusScope.of(context).unfocus();
              }
              Navigator.of(context).pop();
            },
            text: "Close"),
      ],
    );
  }
}
