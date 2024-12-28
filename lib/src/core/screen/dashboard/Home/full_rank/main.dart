import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/model/AqiRankModel.dart';
import 'package:pollusafe_app/src/core/screen/data/conditional/colorAqi.dart';

class FullRank extends ConsumerStatefulWidget {
  const FullRank({super.key});

  @override
  ConsumerState<FullRank> createState() => _FullRankState();
}

class _FullRankState extends ConsumerState<FullRank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "AQI Rank",
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeApp.h16,
            vertical: SizeApp.h16,
          ),
          child: FutureBuilder(
            future: AqiRank().fetchDataAqiRank(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshots.data![index]["station"]['name'] ?? "",
                        style: GoogleFonts.roboto(
                          color: ColorApp.darkBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeApp.customHeight(14),
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
                        width: SizeApp.customWidth(40),
                        height: SizeApp.customWidth(40),
                        decoration: BoxDecoration(
                          color: ColorApp.green,
                          borderRadius: BorderRadius.circular(
                            SizeApp.customWidth(80),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeApp.customWidth(16),
                            ),
                          ),
                        ),
                      ),
                      trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              SizeApp.customWidth(10),
                            ),
                            color: AqiIndicator.getColor(
                              int.parse(snapshots.data![index]['aqi']),
                            ),
                          ),
                          width: SizeApp.h56,
                          height: SizeApp.h56,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min
                            children: [
                              Transform.translate(
                                offset: const Offset(
                                    -3, -1), // Move the text upwards
                                child: Text(
                                  " ${snapshots.data![index]['aqi']}",
                                  style: GoogleFonts.roboto(
                                    fontSize: SizeApp.h16,
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
        ));
  }
}
