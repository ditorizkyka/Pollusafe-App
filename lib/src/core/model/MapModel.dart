import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/search_cities.dart';
import 'package:http/http.dart' as http;

class MapModel implements TileProvider {
  double? longitude_city;
  double? latitude_city;
  String? cityName;

  MapModel({
    this.longitude_city,
    this.latitude_city,
    this.cityName,
  });

  void setMap(double longitude, double latitude) {
    longitude_city = longitude;
    latitude_city = latitude;
  }

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    // print("String owoww${x} dan ${y}");

    // URL dari tile dengan token yang sudah digantikan
    final url =
        '${dotenv.env['ENDPOINT_TILE']}usepa-aqi/$zoom/$x/$y.png?token=${dotenv.env['APIKEY_WAQI']}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // print("DISINI");
        // Mengembalikan Tile dari bytes gambar
        return Tile(256, 256, response.bodyBytes);
      } else {
        // Mengembalikan Tile kosong jika tidak berhasil memuat
        return Tile(256, 256, Uint8List(0));
      }
    } catch (e) {
      print('Error loading tile: $e');
      // Mengembalikan Tile kosong jika terjadi kesalahan
      return Tile(256, 256, Uint8List(0));
    }
  }

  MapModel setDatabySearch(String cityName) {
    for (var city in SearchCities.cities.keys) {
      if (city.toLowerCase() == cityName.toLowerCase()) {
        return MapModel(
          latitude_city: SearchCities.cities[city]!["latitude"]!,
          longitude_city: SearchCities.cities[city]!["longitude"]!,
        );
      }
    }
    return MapModel(
        longitude_city: 0,
        latitude_city: 0); // Kembalikan null jika kota tidak ditemukan
  }
}
