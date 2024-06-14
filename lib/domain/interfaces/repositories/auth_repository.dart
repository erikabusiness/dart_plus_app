abstract class AuthRepository {
  Future<void> registerUser(
      {required String name, required String email, required String password});

  Future<void> loginUser({required String email, required String password});
}
