class FetchMap {
  double long;
  double lat;

  FetchMap({required this.long, required this.lat});

  static const cities = {
    "Jakarta": {
      "latitude": -6.2088,
      "longitude": 106.8456,
    },
    "Washington, D.C.": {
      "latitude": 38.9072,
      "longitude": -77.0369,
    },
    "Tokyo": {
      "latitude": 35.6895,
      "longitude": 139.6917,
    },
    "London": {
      "latitude": 51.5074,
      "longitude": -0.1278,
    },
    "Paris": {
      "latitude": 48.8566,
      "longitude": 2.3522,
    },
    "Berlin": {
      "latitude": 52.5200,
      "longitude": 13.4050,
    },
    "Canberra": {
      "latitude": -35.2809,
      "longitude": 149.1300,
    },
    "Brasília": {
      "latitude": -15.8267,
      "longitude": -47.9218,
    },
    "Ottawa": {
      "latitude": 45.4215,
      "longitude": -75.6972,
    },
    "Beijing": {
      "latitude": 39.9042,
      "longitude": 116.4074,
    },
    "Moscow": {
      "latitude": 55.7558,
      "longitude": 37.6173,
    },
    "Pretoria": {
      "latitude": -25.7479,
      "longitude": 28.2293,
    },
    "New Delhi": {
      "latitude": 28.6139,
      "longitude": 77.2090,
    },
    "Rome": {
      "latitude": 41.9028,
      "longitude": 12.4964,
    },
    "Mexico City": {
      "latitude": 19.4326,
      "longitude": -99.1332,
    },
    "Seoul": {
      "latitude": 37.5665,
      "longitude": 126.9780,
    },
    "Cairo": {
      "latitude": 30.0444,
      "longitude": 31.2357,
    },
    "Buenos Aires": {
      "latitude": -34.6037,
      "longitude": -58.3816,
    },
    "Ankara": {
      "latitude": 39.9334,
      "longitude": 32.8597,
    },
    "Riyadh": {
      "latitude": 24.7136,
      "longitude": 46.6753,
    },
    "Surabaya": {
      "latitude": -7.2575,
      "longitude": 112.7521,
    },
    "Bandung": {
      "latitude": -6.9175,
      "longitude": 107.6191,
    },
    "Medan": {
      "latitude": 3.5952,
      "longitude": 98.6722,
    },
    "Bekasi": {
      "latitude": -6.2383,
      "longitude": 106.9756,
    },
    "Semarang": {
      "latitude": -6.9667,
      "longitude": 110.4167,
    },
    "Makassar": {
      "latitude": -5.1477,
      "longitude": 119.4327,
    },
    "Tangerang": {
      "latitude": -6.1783,
      "longitude": 106.6319,
    },
    "Palembang": {
      "latitude": -2.9909,
      "longitude": 104.7565,
    },
    "Denpasar": {
      "latitude": -8.6500,
      "longitude": 115.2167,
    },
    "Yogyakarta": {
      "latitude": -7.7975,
      "longitude": 110.3695,
    },
    "Malang": {
      "latitude": -7.9666,
      "longitude": 112.6326,
    },
    "Pontianak": {
      "latitude": 0.0263,
      "longitude": 109.3425,
    },
    "Pekanbaru": {
      "latitude": 0.5333,
      "longitude": 101.4500,
    },
    "Balikpapan": {
      "latitude": -1.2654,
      "longitude": 116.8312,
    },
    "Banjarmasin": {
      "latitude": -3.3167,
      "longitude": 114.5908,
    },
    "Manado": {
      "latitude": 1.4748,
      "longitude": 124.8421,
    },
    "Padang": {
      "latitude": -0.9471,
      "longitude": 100.4172,
    },
    "Samarinda": {
      "latitude": -0.5022,
      "longitude": 117.1536,
    },
    "Batam": {
      "latitude": 1.0456,
      "longitude": 104.0305,
    }
  };

  static FetchMap? fetchGeo(String val) {
    for (var city in FetchMap.cities.keys) {
      if (city.toLowerCase() == val.toLowerCase()) {
        return FetchMap(
          lat: FetchMap.cities[city]!["latitude"]!,
          long: FetchMap.cities[city]!["longitude"]!,
        );
      }
    }
    return FetchMap(
        long: 0, lat: 0); // Kembalikan null jika kota tidak ditemukan
  }
}
