import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/services/auth_services.dart';

import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:pollusafe_app/src/core/screen/auth/signin/widgets/signin_field.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/signup.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signInUser() async {
    setState(() {
      CircularProgressIndicator(); // Menampilkan loading sebelum sign-in
    });

    String res = await AuthServices()
        .signIn(email: emailController.text, password: passwordController.text);
    if (res == '200 OK') {
      CircularProgressIndicator();
      context.goNamed('dashboard');
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialogApp(
              title: "Error", description: "Invalid email or password"));
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
            padding: const EdgeInsets.fromLTRB(24, 100, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi There!👋",
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.darkBlue,
                    )),
                Gap.h8,
                Text("Welcome back, Sign in to your account",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.darkGrey,
                    )),
                Gap.h40,
                SigninField(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                Gap.h12,
                // TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       "Forgot Password?",
                //       style: GoogleFonts.roboto(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //         color: ColorApp.green,
                //       ),
                //     )),
                Gap.h8,
                Row(
                  children: [
                    Expanded(
                      child: ButtonApp(
                        onPressed: () {
                          // signInUser();
                          context.goNamed('dashboard');
                        },
                        text: "Sign In",
                      ),
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
              "Don't have an account?",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorApp.darkGrey,
              ),
            ),
            TextButton(
              onPressed: () {
                context.goNamed('signup');
              },
              child: Text(
                "Sign Up",
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
