import 'package:authentication_repository/authentication_repostory.dart';
import 'package:dio/dio.dart';
import 'package:user_repository/user_repostory.dart';

class FirebaseUserService extends UserService {
  final _dio = Dio(
    BaseOptions(baseUrl: "https://retsept-acd0d-default-rtdb.firebaseio.com"),
  );

  @override
  Future<Auth> addUser(String id, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(
        "/users/$id.json",
        data: data,
      );

      return Auth.fromMap(response.data);
    } on DioException catch (e) {
      print("------------------------------------------------------");
      print(e);
      throw (e.response?.data);
    } catch (e) {
   
      rethrow;
    }
  }

  @override
  Future<User> getUser(String id) async {
    try {
      final response = await _dio.get("/users/$id.json");
      final userMap = response.data;
      userMap['id'] = id;
      return User.fromMap(userMap);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
