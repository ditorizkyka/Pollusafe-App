import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AirQualityIndex {
  dynamic aqi;
  dynamic temp;

  String? city;
  String? time;

  dynamic pm10;
  dynamic pressure;
  dynamic humudity;
  dynamic wind;

  AirQualityIndex({
    this.aqi,
    this.temp,
    this.city,
    this.time,
    this.pm10,
    this.wind,
    this.humudity,
    this.pressure,
    // this.rankList = const [],
  });

  factory AirQualityIndex.fromJson(Map<String, dynamic> json) {
    return AirQualityIndex(
      aqi: json['data']?['aqi'].toString() ?? "0",
      temp: json['data']?['iaqi']?['t']?['v'].toString() ?? "0",
      city: json['data']?['city']?['name'].toString() ?? 'Unknown',
      time: json['data']?['time']?['s'].toString() ?? 'Unknown',
      pm10: json['data']?['iaqi']?['pm10']?['v'].toString() ?? "0",
      humudity: json['data']?['iaqi']?['h']?['v'].toString() ?? "0",
      wind: json['data']?['iaqi']?['w']?['v'].toString() ?? "0",
      pressure: json['data']?['iaqi']?['p']?['v'].toString() ?? "0",
    );
  }

  Future<AirQualityIndex?> fetchDataAqi() async {
    try {
      /// Determine the current position of the device.
      ///
      /// When the location services are not enabled or permissions
      /// are denied the `Future` will return an error.
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position position = await Geolocator.getCurrentPosition();

      // ${position.latitude}

      final url1 = Uri.parse(
          '${dotenv.env['ENDPOINT_MAINDATA']}geo:${position.latitude};${position.longitude}/?token=${dotenv.env['APIKEY_WAQI']}');
      // final url2 = Uri.parse(
      //     'https://api.waqi.info/search/?token=$apiKey&keyword=indonesia');

      var response = await http.get(url1);

      if (response.statusCode == 200) {
        AirQualityIndex airQualityIndex =
            AirQualityIndex.fromJson(jsonDecode(response.body));

        return airQualityIndex;
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List> fetchRankData() async {
    List rankList = [];
    var response = await http.get(Uri.parse(
        "${dotenv.env['ENDPOINT_RANK']}?token=${dotenv.env['APIKEY_WAQI']}&keyword=indonesia"));
    var data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    data.forEach((value) {
      rankList.add(value);
    });

    return rankList;
  }
}
