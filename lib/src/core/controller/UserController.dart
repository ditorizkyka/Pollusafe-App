import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pollusafe_app/src/core/model/UserModel.dart';

class UserController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  Rx<double> defaultLong = Rx<double>(107.62816);
  Rx<double> defaultLat = Rx<double>(-6.969282); // -6.969282>

  Future<void> userData() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference users = firestore.collection('users');
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .get();
    var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
    Position position = await UserModel().fetchCoordinate();

    if (userData['uid'] == user.uid) {
      userModel.value = UserModel(
        name: userData['name'],
        email: userData['email'],
        uid: userData['uid'],
        defaultAqi: userData['aqi'],
        longitude: position.longitude,
        latitude: position.latitude,
      );
    } else {
      userModel.value = UserModel(
        name: "Anonymous",
        email: "null",
        uid: "xxx",
        defaultAqi: 100,
        longitude: 107.62816,
        latitude: -6.969282,
      );
    }
  }

  static Future<UserModel?> passData() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference users = firestore.collection('users');
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .get();

    var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

    if (userData['uid'] == user.uid) {
      return UserModel(
        name: userData['name'],
        email: userData['email'],
        uid: userData['uid'],
        defaultAqi: userData['aqi'],
      );
    } else {
      return UserModel(
        name: "Anonymous",
        email: "null",
        uid: "xxx",
        defaultAqi: 0,
      );
    }
  }
}
