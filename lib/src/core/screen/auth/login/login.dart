import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:pollusafe_app/src/core/controller/UserController.dart';
import 'package:pollusafe_app/src/core/model/UserModel.dart';
import 'package:pollusafe_app/src/core/screen/auth/login/widgets/login_field.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/signup.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // USE CASE FR-004 : USER LOGIN ACCOUNT

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    // 1.1 setelah buka
    // setState(
    //   () {
    //     const CircularProgressIndicator(); // Menampilkan loading sebelum sign-in
    //   },
    // );

    // 1.2 Melakukan proses signin dengan method dari UserModel yaitu authLogin()
    String res = await UserModel().authLogin(
        email: emailController.text, password: passwordController.text);

    if (res == '200 OK') {
      final userController = Get.put(UserController());
      userController.userData();
      context.goNamed('dashboard');
    } else {
      // 1.3 Gagal Login, dia akan menampilkan dialog app
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
                LoginField(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                Gap.h12,
                Gap.h8,
                Row(
                  children: [
                    Expanded(
                      child: ButtonApp(
                        onPressed: () {
                          loginUser();
                          // context.goNamed('dashboard');
                        },
                        text: "Log In",
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
