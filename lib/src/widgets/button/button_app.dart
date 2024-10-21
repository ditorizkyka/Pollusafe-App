import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';

// ignore: must_be_immutable
class ButtonApp extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  Color? backgroundcolor;
  ButtonApp({
    this.backgroundcolor = ColorApp.darkBlue,
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Mengatur border radius
        ),
        backgroundColor: backgroundcolor,
        minimumSize: const Size(double.infinity, 56),
        elevation: 3,
      ),
      child: Text(text,
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
