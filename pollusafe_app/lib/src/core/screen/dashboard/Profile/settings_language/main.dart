import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';

class SettingsLanguage extends StatefulWidget {
  const SettingsLanguage({super.key});

  @override
  State<SettingsLanguage> createState() => _SettingsLanguageState();
}

class _SettingsLanguageState extends State<SettingsLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Language",
            style: GoogleFonts.roboto(
              color: ColorApp.darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search Language",
                    hintStyle:
                        const TextStyle(color: ColorApp.darkGrey, fontSize: 14),
                    prefixIcon:
                        const Icon(Icons.search, color: ColorApp.darkBlue),
                    labelStyle: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 238, 240, 244),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                Gap.h20,
                ListTile(
                  // leading: SvgPicture.asset(
                  //   "assets/icon/eng_flag.svg",
                  //   width: 20,
                  //   height: 20,
                  //   color: ColorApp.green,
                  // ),
                  title: Text(
                    "English",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.darkBlue,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.check,
                    color: ColorApp.green,
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
        ));
  }
}
