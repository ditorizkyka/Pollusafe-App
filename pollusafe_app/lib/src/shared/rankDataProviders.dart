import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final rankDataProvider = Provider((ref) async {
  List rankList = [];
  var response = await http.get(Uri.parse(
      "https://api.waqi.info/search/?token=15a6f6d5bcf8d0e0ce2885d4efaf64388d32d860&keyword=indonesia"));
  var data = (json.decode(response.body) as Map<String, dynamic>)["data"];
  data.forEach((value) {
    rankList.add(value);
  });

  return rankList;
});
