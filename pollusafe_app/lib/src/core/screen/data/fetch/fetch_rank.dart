import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
