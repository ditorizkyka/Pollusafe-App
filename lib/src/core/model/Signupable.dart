abstract class Signupable {
  Future<String> authSignUp(
      {required String email, required String password, required String name});
}
