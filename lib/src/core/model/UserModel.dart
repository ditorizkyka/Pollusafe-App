import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pollusafe_app/src/core/model/Loginable.dart';
import 'package:pollusafe_app/src/core/model/Signupable.dart';
import 'package:pollusafe_app/src/widgets/notification/local_notification.dart';
import 'package:geolocator/geolocator.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

class UserModel implements Loginable, Signupable {
  String name;
  String email;
  String uid;
  int aqi;
  double longitude;
  double latitude;

  UserModel({
    this.longitude = 22.0,
    this.latitude = 22.0,
    this.name = "user",
    this.email = "null",
    this.uid = "xxx",
    this.aqi = 100,
  });

  @override
  Future<String> authLogin({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // login user with email and password
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "200 OK";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> authSignUp(
      {required String email,
      required String password,
      required String name}) async {
    // ignore: unused_local_variable
    String res = "Some error occured";
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      // for register with email and password
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // for add user to firestore
        await firestore.collection("users").doc(credential.user!.uid).set({
          "name": name,
          "email": email,
          "uid": credential.user!.uid,
          "aqi": 100,
        });

        res = "200 OK";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  void getNotification() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        LocalNotification.showSimpleNotification(
            title: "You are in danger",
            body: "Hei User, Keep your day with mask!",
            payload: "halo");
      },
    );
  }

  void editAqiLevel(String uidUser, int aqiController) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    users.doc(uidUser).update({
      'aqi': aqiController,
    });
  }

  void displayMap() {}

  bool positionStreamStarted = false;
  Future<Position> fetchCoordinate() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
