import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // For storing data in firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // for signup
  Future<String> signUp(
      {required String email,
      required String password,
      required String name}) async {
    // ignore: unused_local_variable
    String res = "Some error occured";
    try {
      // for register with email and password
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // for add user to firestore
        await _firestore.collection("users").doc(credential.user!.uid).set({
          "name": name,
          "email": email,
          "uid": credential.user!.uid,
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

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // login user with email and password
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "200 OK";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }
}
