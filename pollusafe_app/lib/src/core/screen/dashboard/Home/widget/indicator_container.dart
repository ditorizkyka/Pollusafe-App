import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';
import 'package:pollusafe_app/src/core/screen/data/passData/pass_data.dart';
import 'package:pollusafe_app/src/shared/aqi_settings_provider.dart';
import 'package:pollusafe_app/src/shared/data_aqi_provider.dart';
import 'package:pollusafe_app/src/widgets/notification/local_notification.dart';

class IndicatorContainer extends ConsumerStatefulWidget {
  final String location;
  final dynamic aqi;
  final dynamic temp;
  final String time;

  const IndicatorContainer({
    required this.location,
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

    return dataStream.when(
      data: (data) {
        // Membandingkan data baru dengan data sebelumnya
        if (_previousData != null &&
            data!.aqi != _previousData!.aqi &&
            data.aqi >= ref.watch(aqiSettingsProvider)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LocalNotification.showSimpleNotification(
                title: "You are in danger",
                body: "Hei User, Keep your day with mask!",
                payload: "halo");
          });
        }

        // Menyimpan data baru sebagai data sebelumnya untuk perbandingan berikutnya
        _previousData = data;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          width: double.infinity,
          height: 289,
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
                height: 160,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
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
                                  data!.city,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: ColorApp.darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            Gap.h8,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AqiIndicator.getStatus(data.aqi),
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: ColorApp.darkBlue,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Row(
                                  children: [
                                    AqiRes(
                                        title: "AQI", idx: data.aqi.toString()),
                                    Gap.w12,
                                    AqiRes(
                                        title: "Temp",
                                        idx: data.temp.toString()),
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
                        "Last Updated : ${data.time}",
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
        );
      },
      loading: () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        height: 289,
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
              height: 160,
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

class GreetingsHome extends StatelessWidget {
  const GreetingsHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: passData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome back!",
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.white)),
                Gap.h4,
                Text(snapshot.data!.name,
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
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
      width: 55,
      height: 55,
      decoration: const BoxDecoration(
        color: ColorApp.green,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            idx,
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -2), // Move the text upwards
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
