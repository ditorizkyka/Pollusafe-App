import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollusafe_app/src/core/model/UserModel.dart';

final userDataProvider = Provider((ref) async {
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
      aqi: userData['aqi'],
    );
  } else {
    return UserModel(
      name: "Anonymous",
      email: "null",
      uid: "xxx",
      aqi: 100,
    );
  }
});

// final rankData = Provider((ref) {
//   return "Halo";
// });

