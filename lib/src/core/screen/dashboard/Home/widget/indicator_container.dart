import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/controller/UserController.dart';
import 'package:pollusafe_app/src/core/model/UserModel.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';
import 'package:pollusafe_app/src/shared/aqi_settings_provider.dart';
import 'package:pollusafe_app/src/shared/data_aqi_provider.dart';
import 'package:pollusafe_app/src/shared/uid_provider.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class IndicatorContainer extends ConsumerStatefulWidget {
  final String location;
  final dynamic aqi;
  final dynamic temp;
  final String time;
  final int settingAqiNew;

  const IndicatorContainer({
    required this.location,
    required this.settingAqiNew,
    this.aqi,
    this.temp,
    required this.time,
    super.key,
  });

  @override
  ConsumerState<IndicatorContainer> createState() => _IndicatorContainerState();
}

class _IndicatorContainerState extends ConsumerState<IndicatorContainer> {
  // ignore: prefer_typing_uninitialized_variables
  var _previousData; // Variable untuk menyimpan data sebelumnya

  @override
  Widget build(BuildContext context) {
    final dataStream = ref.watch(dataProvider);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return dataStream.when(
      data: (data) {
        // Membandingkan data baru dengan data sebelumnya

        // Menyimpan data baru sebagai data sebelumnya untuk perbandingan berikutnya
        // int.parse(data!.aqi) >= ref.read(aqiSettingsProvider.notifier).state
        dynamic previousData = data!.aqi;

        return StreamBuilder(
            stream: users.doc(ref.read(uidUser)).snapshots(),
            builder: (context, snap) {
              if (snap.hasData) {
                //  SETTINGAN ASLI
                // if (previousData != data.aqi && int.parse(data.aqi) >
                //     ref.read(aqiSettingsProvider.notifier).state) {
                //   UserModel().getNotification(
                //       AqiIndicator.getStatus(int.parse(data.aqi)));
                // }
                if (int.parse(data.aqi) >
                    ref.read(aqiSettingsProvider.notifier).state) {
                  UserModel().getNotification(
                      AqiIndicator.getStatus(int.parse(data.aqi)));
                }
              }

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorApp.green,
                      Color.fromARGB(255, 10, 88, 68),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppbarCustomHome(),
                    Gap.h24,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(SizeApp.h20),
                        ),
                        color: ColorApp.darkBlue,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(SizeApp.h20),
                                  bottomLeft: Radius.circular(SizeApp.h20),
                                  bottomRight: Radius.circular(SizeApp.h20),
                                  topRight: Radius.circular(SizeApp.h20)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeApp.h20,
                                vertical: SizeApp.h16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: ColorApp.darkBlue,
                                      ),
                                      Gap.w4,
                                      Text(
                                        data.city!,
                                        style: GoogleFonts.roboto(
                                          fontSize: SizeApp.h12,
                                          color: ColorApp.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap.h16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          AqiIndicator.getStatus(
                                            int.parse(data.aqi),
                                          ),
                                          style: GoogleFonts.roboto(
                                            fontSize: SizeApp.h28,
                                            color: ColorApp.darkBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          AqiRes(
                                            title: "AQI",
                                            idx: data.aqi.toString(),
                                          ),
                                          Gap.w12,
                                          AqiRes(
                                            title: "Temp",
                                            idx: data.temp.toString(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 13),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: ColorApp.darkBlue,
                            ),
                            child: Text(
                              "Last Updated : ${data.time}",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: SizeApp.h12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      loading: () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorApp.green,
              Color.fromARGB(255, 10, 88, 68),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const GreetingsHome(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            Gap.h24,
            Container(
              width: double.infinity,
              height: SizeApp.customHeight(160),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorApp.darkBlue,
              ),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: ColorApp.darkBlue,
                    ),
                    child: Text(
                      "Loading data...",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}

class AppbarCustomHome extends StatelessWidget {
  const AppbarCustomHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const GreetingsHome(),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    "About Pollusafe App",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                content: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              color: ColorApp.green,
                              width: SizeApp.h64,
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/logo/pollusafe.png"),
                            ),
                            Container(
                              width: SizeApp.h80,
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/logo/telkomLogo.png"),
                            ),
                          ],
                        ),
                        Gap.h16,
                        Text(
                          "Pollusafe is an Air Quality monitoring app, that provides information about the Air Quality Index in your area! The main purpose of this app is to give alert to other people in the city with their Air Quality index to avoid/decrease respiratory desease caused bad Air quality",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: SizeApp.h12,
                            fontWeight: FontWeight.w400,
                            color: ColorApp.darkBlue,
                          ),
                        ),
                        Gap.h16,
                        Text(
                          "Developed By :",
                          style: GoogleFonts.roboto(
                            fontSize: SizeApp.h16,
                            fontWeight: FontWeight.w500,
                            color: ColorApp.darkBlue,
                          ),
                        ),
                        Gap.h20,
                        Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ShortProfile(
                                  imageAsset: 'assets/team/dito.JPG',
                                  instagramAcc: "@ditorizkyka_",
                                ),
                                ShortProfile(
                                  imageAsset: 'assets/team/fariz.jpg',
                                  instagramAcc: "@farizrjanuar",
                                ),
                              ],
                            ),
                            Gap.h24,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShortProfile(
                                  imageAsset: 'assets/team/hilal.jpg',
                                  instagramAcc: "@abeeyyn",
                                ),
                                ShortProfile(
                                  imageAsset: 'assets/team/imam.jpg',
                                  instagramAcc: "@_imamwijaya",
                                ),
                                ShortProfile(
                                  imageAsset: 'assets/team/hazna.jpg',
                                  instagramAcc: "@haznahhs",
                                ),
                              ],
                            ),
                            // Gap.h24,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ButtonApp(
                      onPressed: () {
                        if (true == true) {
                          FocusScope.of(context).unfocus();
                        }
                        Navigator.of(context).pop();
                      },
                      text: "Close"),
                ],
              ),
            );
          },
          icon: Icon(
            Icons.info_outline,
            color: Colors.white,
            size: SizeApp.h28,
          ),
        ),
      ],
    );
  }
}

class ShortProfile extends StatelessWidget {
  final String imageAsset;
  final String instagramAcc;
  const ShortProfile({
    this.imageAsset = "",
    this.instagramAcc = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            color:
                Colors.grey[200], // Optional: background color for the circle
            width: SizeApp.h64, // Diameter of the circle
            height: SizeApp.h64, // Diameter of the circle
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap.h16, // Spacing between image and text
        Text(
          instagramAcc,
          style: GoogleFonts.roboto(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: ColorApp.darkBlue),
        ),
      ],
    );
  }
}

class GreetingsHome extends StatelessWidget {
  const GreetingsHome({
    super.key,
  });

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserController.passData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back!",
                  style: GoogleFonts.roboto(
                      fontSize: SizeApp.h16, color: Colors.white),
                ),
                Gap.h4,
                Text(
                  snapshot.data!.name,
                  style: GoogleFonts.roboto(
                    fontSize: SizeApp.h24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Text("User");
          }
        });
  }
}

class AqiRes extends StatelessWidget {
  final String idx;
  final String title;

  const AqiRes({
    required this.idx,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeApp.w52,
      height: SizeApp.w52,
      decoration: BoxDecoration(
        color: ColorApp.green,
        borderRadius: BorderRadius.all(
          Radius.circular(SizeApp.h12),
        ),
      ),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            idx,
            style: GoogleFonts.roboto(
              fontSize: SizeApp.h20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -2), // Move the text upwards
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: SizeApp.h12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
