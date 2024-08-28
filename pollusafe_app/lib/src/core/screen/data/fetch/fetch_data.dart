import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:pollusafe_app/src/core/screen/data/model/air_quality.dart';
import 'package:http/http.dart' as http;
// import 'package:pollusafe_app/src/core/screen/data/model/aqi_rank.dart';

// API KEY
const apiKey = "15a6f6d5bcf8d0e0ce2885d4efaf64388d32d860";

Future<AirQuality?> fetchData() async {
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
    // Position position = await Geolocator.getCurrentPosition();
    String latTelkom = "-6.969282";
    String longTelkom = "107.62816";

    final url1 = Uri.parse(
        'https://api.waqi.info/feed/geo:${latTelkom};${longTelkom}/?token=$apiKey');
    // final url2 = Uri.parse(
    //     'https://api.waqi.info/search/?token=$apiKey&keyword=indonesia');

    var response = await http.get(url1);

    if (response.statusCode == 200) {
      AirQuality airQuality = AirQuality.fromJson(jsonDecode(response.body));

      return airQuality;
    }
    return null;
  } catch (e) {
    rethrow;
  }
}
