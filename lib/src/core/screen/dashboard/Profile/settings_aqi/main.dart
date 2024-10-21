import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/signup.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';
import 'package:pollusafe_app/src/shared/aqi_settings_provider.dart';

import 'package:pollusafe_app/src/shared/uid_provider.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class SettingsAqi extends ConsumerStatefulWidget {
  const SettingsAqi({super.key});

  @override
  ConsumerState<SettingsAqi> createState() => _SettingsAqiState();
}

class _SettingsAqiState extends ConsumerState<SettingsAqi> {
  TextEditingController aqiController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    changeAqi(int aqiController) {
      users.doc(ref.read(uidUser)).update({
        'aqi': aqiController,
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        child: StreamBuilder(
            stream: users.doc(ref.read(uidUser)).snapshots(),
            builder: (_, snap) {
              if (snap.hasData) {
                return Container(
                  color: Colors.white,
                  height: screenHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 70),
                        child: Column(
                          children: [
                            Container(
                              // padding: const EdgeInsets.symmetric(vertical: 25),
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AqiIndicator.getColor(snap.data!['aqi'])
                                            .withOpacity(0.5), // Warna bayangan
                                    spreadRadius: 10, // Mengatur lebar bayangan
                                    blurRadius: 10, // Mengatur intensitas blur
                                    offset: const Offset(
                                        0, 0), // Posisi bayangan (x, y)
                                  ),
                                ],
                                color: ColorApp.green,
                                borderRadius: BorderRadius.circular(160),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snap.data!['aqi'].toString(),
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
                                      fontWeight: FontWeight.w400,
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
                                        color: const Color.fromARGB(
                                            255, 215, 216, 220)),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                focusColor: Colors.red,
                                                filled: true,
                                                fillColor: const Color.fromARGB(
                                                    255, 238, 240, 244),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(10),
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
                                    FocusScope.of(context).unfocus();
                                    if (aqiController.text.isNotEmpty) {
                                      changeAqi(int.parse(aqiController.text));
                                      ref
                                          .read(aqiSettingsProvider.notifier)
                                          .state = int.parse(aqiController.text);
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialogApp(
                                                  title:
                                                      "Successfully Updated!😁",
                                                  description:
                                                      "Your index has been updated, we will notify you as soon as possible!"));
                                    } else if (aqiController.text == "") {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialogApp(
                                                  unFocus: true,
                                                  title: "Error, Empty Field",
                                                  description:
                                                      "Please fill out the field"));
                                    }
                                  },
                                ),
                                Gap.h16,
                                Text(
                                    "Your index automatically saved into our database!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: ColorApp.darkGrey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Colors.white,
                  height: screenHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 70),
                        child: Column(
                          children: [
                            Container(
                              // padding: const EdgeInsets.symmetric(vertical: 25),
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AqiIndicator.getColor(0)
                                        .withOpacity(0.5), // Warna bayangan
                                    spreadRadius: 10, // Mengatur lebar bayangan
                                    blurRadius: 10, // Mengatur intensitas blur
                                    offset: const Offset(
                                        0, 0), // Posisi bayangan (x, y)
                                  ),
                                ],
                                color: ColorApp.green,
                                borderRadius: BorderRadius.circular(160),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Null",
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
                                      fontWeight: FontWeight.w400,
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
                                        color: const Color.fromARGB(
                                            255, 215, 216, 220)),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                focusColor: Colors.red,
                                                filled: true,
                                                fillColor: const Color.fromARGB(
                                                    255, 238, 240, 244),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(10),
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
                                    FocusScope.of(context).unfocus();
                                    if (aqiController.text.isNotEmpty) {
                                      changeAqi(int.parse(aqiController.text));

                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialogApp(
                                                  title:
                                                      "Successfully Updated!😁",
                                                  description:
                                                      "Your index has been updated, we will notify you as soon as possible!"));
                                    } else if (aqiController.text == "") {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialogApp(
                                                  unFocus: true,
                                                  title: "Error, Empty Field",
                                                  description:
                                                      "Please fill out the field"));
                                    }
                                  },
                                ),
                                Gap.h16,
                                Text(
                                    "Your index automatically saved into our database!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: ColorApp.darkGrey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
