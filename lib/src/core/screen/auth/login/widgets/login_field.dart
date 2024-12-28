import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';

// ignore: must_be_immutable
class LoginField extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginField({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorApp.darkGrey,
            ),
            filled: true,
            fillColor: ColorApp.lightGrey,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        Gap.h8,
        TextField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorApp.darkGrey,
            ),
            filled: true,
            fillColor: ColorApp.lightGrey,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        )
      ],
    );
  }
}
