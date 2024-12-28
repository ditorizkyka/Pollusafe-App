import 'package:flutter/material.dart';
import 'package:pollusafe_app/src/constant/constant.dart';

class AqiIndicator {
  int aqi;
  String status;

  AqiIndicator({required this.aqi, required this.status});

  static String setStatus(int aqi) {
    if (aqi > 300) {
      return "Hazardous";
    } else if (aqi > 200 && aqi <= 300) {
      return "Very Unhealthy";
    } else if (aqi > 150 && aqi <= 200) {
      return "Unhealthy";
    } else if (aqi > 100 && aqi <= 150) {
      return "Unhealthy for Sensitive Groups";
    } else if (aqi > 50 && aqi <= 100) {
      return "Moderate";
    } else if (aqi > 0 && aqi <= 50) {
      return "Good";
    } else {
      return "Out Of indicator Range";
    }
  }

  static Color setColor(int aqi) {
    if (aqi > 300) {
      return const Color.fromARGB(255, 101, 6, 6);
    } else if (aqi > 200 && aqi <= 300) {
      return const Color.fromARGB(255, 117, 7, 137);
    } else if (aqi > 150 && aqi <= 200) {
      return Colors.red;
    } else if (aqi > 100 && aqi <= 150) {
      return Colors.orange;
    } else if (aqi > 50 && aqi <= 100) {
      return Colors.yellow;
    } else if (aqi > 0 && aqi <= 50) {
      return Colors.green;
    } else {
      return ColorApp.lightGrey;
    }
  }
}
