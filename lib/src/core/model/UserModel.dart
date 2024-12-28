import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollusafe_app/src/core/controller/UserController.dart';
import 'package:pollusafe_app/src/core/model/Loginable.dart';
import 'package:pollusafe_app/src/core/model/MapModel.dart';
import 'package:pollusafe_app/src/core/model/Notificationable.dart';
import 'package:pollusafe_app/src/core/model/Signupable.dart';
import 'package:pollusafe_app/src/widgets/notification/local_notification.dart';
import 'package:geolocator/geolocator.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

class UserModel implements Loginable, Signupable, Notificationable {
  String name;
  String email;
  String uid;
  int defaultAqi;
  double longitude;
  double latitude;

  UserModel({
    this.longitude = 22.0,
    this.latitude = 22.0,
    this.name = "user",
    this.email = "null",
    this.uid = "xxx",
    this.defaultAqi = 100,
  });

  @override
  Future<String> authLogin({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
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
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        final userController = Get.put(UserController());
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
        userController.userData();
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  void getNotification(String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        LocalNotification.showSimpleNotification(
            title: "Hei Buddy! You are in ${message} level",
            body: "Keep your day with mask or stay at home😁👋",
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

  TileOverlay displayMap() {
    return TileOverlay(
      tileOverlayId: const TileOverlayId('aqiTileOverlay'),
      tileProvider: MapModel(),
    );
  }

  bool positionStreamStarted = false;
  Future<Position> fetchCoordinate() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
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
