import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';

class DetailedInformation extends StatelessWidget {
  final String humudity;
  final String pm10;
  final String wind;
  final String pressure;
  const DetailedInformation({
    required this.humudity,
    required this.pm10,
    required this.wind,
    required this.pressure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   "Here is air quality for Bojongsoang \nRegionToday 25 Apr 2024 :",
            //   style: GoogleFonts.roboto(
            //     fontSize: 12,
            //     fontWeight: FontWeight.w700,
            //     color: ColorApp.darkBlue,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            Gap.h4,
            Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: ColorApp.darkBlue,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReportPerIndicator(
                        idx: humudity.toString(),
                        title: "Humudity",
                      ),
                      ReportPerIndicator(
                        idx: pm10.toString(),
                        title: "PM10",
                      ),
                      ReportPerIndicator(
                        idx: wind.toString(),
                        title: "Wind",
                      ),
                      ReportPerIndicator(
                        idx: pressure.toString(),
                        title: "Pressure",
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}

class ReportPerIndicator extends StatelessWidget {
  final String idx;
  final String title;
  const ReportPerIndicator({
    required this.idx,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            idx,
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ColorApp.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -2), // Move the text upwards
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 10,
                color: ColorApp.darkBlue,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
