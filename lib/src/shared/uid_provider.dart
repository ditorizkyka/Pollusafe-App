import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uidUser = StateProvider((ref) {
  User? user = FirebaseAuth.instance.currentUser;
  return user!.uid;
});
