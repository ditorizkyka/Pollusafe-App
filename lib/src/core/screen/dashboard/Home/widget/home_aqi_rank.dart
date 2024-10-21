import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';
import 'package:go_router/go_router.dart';

class HomeAqiRank extends StatelessWidget {
  final Future<dynamic> fetchdata;
  const HomeAqiRank({
    required this.fetchdata,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Gap.h4,
          FutureBuilder(
              future: fetchdata,
              builder: (context, snap) {
                if (snap.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AqiIndicator.getColor(
                                    int.parse(snap.data[index]['aqi'])),
                              ),
                              width: 55,
                              height: 55,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min
                                children: [
                                  Transform.translate(
                                    offset: const Offset(
                                        -3, -1), // Move the text upwards
                                    child: Text(
                                      " ${snap.data[index]['aqi']}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(
                                        0, -1), // Move the text upwards
                                    child: Text(
                                      'AQI',
                                      style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          title: Text(
                            "${snap.data[index]['station']['name']}",
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "Last updated ${snap.data[index]['time']['stime']}",
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: ColorApp.darkGrey,
                              )),
                        );
                      });
                } else {
                  return const Center(child: Text("Loading..."));
                }
              })
        ]));
  }
}

class HeaderRankList extends StatelessWidget {
  const HeaderRankList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Today, Highest AQI Rank",
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorApp.darkGrey,
            ),
          ),
          TextButton(
              onPressed: () {
                context.goNamed("fullrank");
              },
              child: Row(children: [
                Text(
                  "See More",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ColorApp.darkBlue,
                  ),
                ),
                Gap.w4,
                const Icon(Icons.arrow_forward_ios,
                    size: 12, color: ColorApp.darkBlue),
              ]))
        ],
      ),
    );
  }
}
