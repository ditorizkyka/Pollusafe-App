import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/fetch_data.dart';

final dataProvider = StreamProvider.autoDispose((ref) {
  return Stream.periodic(Duration(seconds: 1), (count) {
    return fetchData(); // Memanggil API setiap 10 detik
  }).asyncMap((_) async => await fetchData());
});
