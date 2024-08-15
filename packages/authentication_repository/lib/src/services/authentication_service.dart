import '../models/models.dart';

abstract class AuthenticationService {
  Future<Auth> login(String email, String password);
  Future<Auth> register(String email, String password);
  Future<Map<String, dynamic>?> getUserInfo();
}
