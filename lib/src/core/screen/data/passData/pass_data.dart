// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pollusafe_app/src/core/model/UserModel.dart';

// Future<UserModel?> passData() async {
//   User? user = FirebaseAuth.instance.currentUser;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   // CollectionReference users = firestore.collection('users');
//   QuerySnapshot querySnapshot = await firestore
//       .collection('users')
//       .where('uid', isEqualTo: user!.uid)
//       .get();
//   var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
//   // print(userData['aqi']);

//   if (userData['uid'] == user.uid) {
//     return UserModel(
//       name: userData['name'],
//       email: userData['email'],
//       uid: userData['uid'],
//       defaultAqi: userData['aqi'],
//     );
//   } else {
//     return UserModel(
//       name: "Anonymous",
//       email: "null",
//       uid: "xxx",
//       defaultAqi: 0,
//     );
//   }
// }
