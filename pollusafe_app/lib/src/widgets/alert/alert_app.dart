import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

// ignore: must_be_immutable
class AlertDialogApp extends StatelessWidget {
  final String title;
  final String description;
  final String? button;
  Function()? onPressed;
  final bool double_button;

  AlertDialogApp({
    this.onPressed,
    required this.title,
    required this.description,
    required this.double_button,
    this.button,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              Navigator.of(context).pop();
            },
            text: "Close"),
        if (double_button)
          ButtonApp(
            backgroundcolor: Colors.red,
            onPressed: onPressed,
            text: "Login",
          ),
      ],
    );
  }
}
