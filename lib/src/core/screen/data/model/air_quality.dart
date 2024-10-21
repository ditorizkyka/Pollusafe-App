class AirQuality {
  dynamic aqi;
  dynamic temp;

  String city;
  String time;

  dynamic pm10;
  dynamic pressure;
  dynamic humudity;
  dynamic wind;

  Object rankList;

  AirQuality({
    required this.aqi,
    required this.temp,
    required this.city,
    required this.time,
    required this.pm10,
    required this.wind,
    required this.humudity,
    required this.pressure,
    this.rankList = const [],
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
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
}
