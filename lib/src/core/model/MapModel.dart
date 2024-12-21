import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_map.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/search_cities.dart';

class MapModel {
  double? longitude_city;
  double? latitude_city;
  String? cityName;

  MapModel({
    this.longitude_city,
    this.latitude_city,
    this.cityName,
  });

  void fetchMapTile(int x, int y, int? zoom) {
    FetchMap fetchMap = FetchMap();
    fetchMap.getTile(x, y, zoom);
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
