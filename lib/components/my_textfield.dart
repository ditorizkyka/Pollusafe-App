
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
    final dynamic controller;
    final String hintText;
    final bool obscureText;

    const MyTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle:  const TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          fillColor: const Color.fromARGB(255, 41, 41, 41),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }

}