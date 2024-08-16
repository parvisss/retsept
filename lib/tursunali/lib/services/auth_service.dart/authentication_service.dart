import 'package:authentication_repository/authentication_repostory.dart';
import 'package:dio/dio.dart';

class FirebaseAuthenticationService extends AuthenticationService {
  final _apiKey = "AIzaSyDHXfZwNIpQceuPLV-RVBN9ZsRL0hMOQ6g";
  final _dio = Dio(
    BaseOptions(baseUrl: "https://identitytoolkit.googleapis.com/v1/accounts:"),
  );

  @override
  Future<Auth> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "signInWithPassword?key=$_apiKey",
        data: {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      );
      print(response.data);
      return Auth.fromJson(response.data);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Auth> register(String email, String password) async {
    try {
      final response = await _dio.post(
        "signUp?key=$_apiKey",
        data: {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      );
      print(response);
      return Auth.fromMap(response.data);
    } on DioException catch (e) {
      print("Bu dio xatoligi: $e");
      throw (e.response?.data);
    } catch (e) {
      print("Bu dio xatoligi: $e");

      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserInfo() async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$_apiKey";

    try {
      final token = await LocalDb.getIdToken();
      if (token != null) {
        final response = await _dio.post(
          url,
          data: {
            'idToken': token,
          },
        );
        print("Bu auth pakcagedagi getUserInfo response: $response");
        return response.data;
      }
      return null;
    } catch (e) {
      print("GetUserInfo da Xatolik: $e");
      rethrow;
    }
  }
}
