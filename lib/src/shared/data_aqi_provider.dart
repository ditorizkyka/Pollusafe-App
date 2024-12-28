import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollusafe_app/src/core/model/AqiModel.dart';

final dataProvider = StreamProvider.autoDispose((ref) {
  return Stream.periodic(Duration(seconds: 1), (count) {
    return AirQualityIndex().fetchDataAqi(); // Memanggil API setiap 10 detik
  }).asyncMap((_) async => await AirQualityIndex().fetchDataAqi());
});
