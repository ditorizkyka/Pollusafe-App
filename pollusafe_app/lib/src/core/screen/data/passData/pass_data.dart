import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pollusafe_app/src/core/screen/data/model/user_model.dart';

Future<UserModel?> passData() async {
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
    );
  } else {
    return UserModel(
      name: "Anonymous",
      email: "null",
      uid: "xxx",
    );
  }
}