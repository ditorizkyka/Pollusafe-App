import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/widget/detail_information.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/widget/home_aqi_rank.dart';
import 'package:pollusafe_app/src/core/screen/dashboard/Home/widget/indicator_container.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_data.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_rank.dart';
import 'package:pollusafe_app/src/core/model/UserModel.dart';
import 'package:pollusafe_app/src/core/screen/data/passData/pass_data.dart';
import 'package:pollusafe_app/src/shared/uid_provider.dart';
// import 'package:flutter/services.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Map<String, dynamic>> rankList = [];

  @override
  void initState() {
    super.initState();
    // scheduleRepeatingNotifications();
    // Initialize fetchRankData here
  }

  // void scheduleRepeatingNotifications() {
  //   Timer.periodic(Duration(minutes: 1), (Timer timer) {
  //     LocalNotification.showScheduleNotification();
  //   });
  // }

  Future getData() async {
    UserModel? data = await passData();
    return data!.aqi;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    // print(getData());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
              future: fetchData(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Container(
                    // height: screenHeight,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: users.doc(ref.read(uidUser)).snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return IndicatorContainer(
                                    location: snap.data!.city,
                                    time: snap.data!.time,
                                    aqi: snap.data!.aqi,
                                    temp: snap.data!.temp,
                                    settingAqiNew: snapshot.data!['aqi']);
                              } else {
                                return IndicatorContainer(
                                    location: snap.data!.city,
                                    time: snap.data!.time,
                                    aqi: snap.data!.aqi,
                                    temp: snap.data!.temp,
                                    settingAqiNew: 100);
                              }
                            }),
                        DetailedInformation(
                          humudity: snap.data!.humudity.toString(),
                          pm10: snap.data!.pm10.toString(),
                          wind: snap.data!.wind.toString(),
                          pressure: snap.data!.pressure.toString(),
                        ),
                        const HeaderRankList(),
                        HomeAqiRank(
                          fetchdata: fetchRankData() as Future<List?>,
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const IndicatorContainer(
                          location: "",
                          time: "",
                          settingAqiNew: 100,
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
