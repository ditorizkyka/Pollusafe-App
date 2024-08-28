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
      aqi: json['data']?['aqi'] ?? 0 as String,
      temp: json['data']?['iaqi']?['t']?['v'] ?? 0 as String,
      city: json['data']?['city']?['name'] ?? 'Unknown',
      time: json['data']?['time']?['s'] ?? 'Unknown',
      pm10: json['data']?['iaqi']?['pm10']?['v'] ?? 0 as String,
      humudity: json['data']?['iaqi']?['h']?['v'] ?? 0 as String,
      wind: json['data']?['iaqi']?['w']?['v'] ?? 0 as String,
      pressure: json['data']?['iaqi']?['p']?['v'] ?? 0 as int,
    );
  }
}
