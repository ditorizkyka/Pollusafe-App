import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/signup.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';
import 'package:pollusafe_app/src/shared/aqi_settings_provider.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class SettingsAqi extends ConsumerStatefulWidget {
  const SettingsAqi({super.key});

  @override
  ConsumerState<SettingsAqi> createState() => _SettingsAqiState();
}

class _SettingsAqiState extends ConsumerState<SettingsAqi> {
  TextEditingController aqiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.roboto(
            color: ColorApp.darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: const EdgeInsets.symmetric(vertical: 25),
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AqiIndicator.getColor(
                              int.parse(ref.watch(aqiSettingsProvider))),
                          width: 6),
                      color: ColorApp.green,
                      borderRadius: BorderRadius.circular(160),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ref.watch(aqiSettingsProvider).toString(),
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "AQI Index",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap.h32,
                  Column(
                    children: [
                      Gap.h16,
                      Text(
                        "Edit Air Quality Index",
                        style: GoogleFonts.roboto(
                          color: ColorApp.darkBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gap.h12,
                      Text(
                          "Change Air Quality Index notification so that\n we can notify based on your settings!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: ColorApp.darkGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                      Gap.h16,
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 215, 216, 220)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enter index : ",
                                    style: GoogleFonts.roboto(
                                        color: ColorApp.darkGrey,
                                        fontSize: 12)),
                                Text("Max AQI 500",
                                    style: GoogleFonts.roboto(
                                        color: ColorApp.darkGrey,
                                        fontSize: 12)),
                              ],
                            ),
                            Gap.h12,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "AQI",
                                  style: GoogleFonts.roboto(
                                      color: ColorApp.darkGrey,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Gap.w4,
                                Text(
                                  ">",
                                  style: GoogleFonts.roboto(
                                    color: ColorApp.darkGrey,
                                    fontSize: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: TextField(
                                    controller: aqiController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      focusColor: Colors.red,
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 238, 240, 244),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: "Input index",
                                      hintStyle: GoogleFonts.roboto(
                                        color: ColorApp.darkGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Gap.h16,
                      ButtonApp(
                        text: "Save",
                        onPressed: () {
                          if (aqiController.text.isNotEmpty) {
                            ref.read(aqiSettingsProvider.notifier).state =
                                (aqiController.text);
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialogApp(
                                    title: "Successfully Updated!😁",
                                    description:
                                        "Your index has been updated, we will notify you as soon as possible!"));
                          } else if (aqiController.text == "") {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialogApp(
                                    title: "Error, Empty Field",
                                    description: "Please fill out the field"));
                          }
                          FocusScope.of(context).unfocus();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
