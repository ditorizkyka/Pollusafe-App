import 'package:flutter/material.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/widget/detail_information.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/widget/home_aqi_rank.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/widget/indicator_container.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_data.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_rank.dart';
// import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> rankList = [];
  @override
  void initState() {
    super.initState(); // Initialize fetchRankData here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
              future: fetchData(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        IndicatorContainer(
                          location: snap.data!.city,
                          time: snap.data!.time,
                          aqi: snap.data!.aqi,
                          temp: snap.data!.temp,
                        ),
                        DetailedInformation(
                          humudity: snap.data!.humudity.toString(),
                          pm10: snap.data!.pm10.toString(),
                          wind: snap.data!.wind.toString(),
                          pressure: snap.data!.pressure.toString(),
                        ),
                        const HeaderRankList(),
                        HomeAqiRank(
                          fetchdata: fetchRankData() as Future<List?>,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        const IndicatorContainer(
                          location: "",
                          time: "",
                        ),
                        const DetailedInformation(
                          humudity: "",
                          pm10: "",
                          wind: "",
                          pressure: "",
                        ),
                        const HeaderRankList(),
                        HomeAqiRank(
                          fetchdata: fetchRankData() as Future<List?>,
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
