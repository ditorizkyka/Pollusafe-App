abstract class Loginable {
  Future<String> authLogin({required String email, required String password});
}
