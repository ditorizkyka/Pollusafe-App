import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FetchMap implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
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
}
