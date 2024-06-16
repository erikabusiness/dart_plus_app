abstract class AuthRepository {
  Future<void> registerUser(
      {required String name, required String email, required String password});

  Future<Map<String,String>> loginUser(
    {required String email, required String password});
}
