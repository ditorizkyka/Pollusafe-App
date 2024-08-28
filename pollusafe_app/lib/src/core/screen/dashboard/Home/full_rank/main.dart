import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_rank.dart';

class FullRank extends ConsumerStatefulWidget {
  const FullRank({super.key});

  @override
  ConsumerState<FullRank> createState() => _FullRankState();
}

class _FullRankState extends ConsumerState<FullRank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "AQI Rank",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: FutureBuilder(
          future: fetchRankData(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              print(snapshots.data);
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshots.data![index]["station"]['name'] ?? "",
                      style: GoogleFonts.roboto(
                        color: ColorApp.darkBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      'Last updated ${snapshots.data![index]["time"]['stime'] ?? ""}',
                      style: GoogleFonts.roboto(
                        color: ColorApp.darkGrey,
                        // fontWeight: ,
                        fontSize: 12,
                      ),
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorApp.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AqiIndicator.getColor(
                              int.parse(snapshots.data![index]['aqi'])),
                        ),
                        width: 40,
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min
                          children: [
                            Transform.translate(
                              offset:
                                  const Offset(-3, -1), // Move the text upwards
                              child: Text(
                                " ${snapshots.data![index]['aqi']}",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset:
                                  const Offset(0, -1), // Move the text upwards
                              child: Text(
                                'AQI',
                                style: GoogleFonts.roboto(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}
