import 'package:dio/dio.dart';
import 'package:retsept_cherno/data/models/user_model.dart';
import 'package:retsept_cherno/tursunali/lib/services/auth_service.dart/authentication_service.dart';

class UserFirestore {
  final String _baseUrl =
      "https://retsept-acd0d-default-rtdb.firebaseio.com"; // Base URL
  final Dio _dio = Dio();

  //? Add a new user to the database
  Future<void> addUser(UserModel user) async {
    try {
      final Map<String, dynamic> userJson = user.toJson();
      final response = await _dio.post("$_baseUrl/users.json", data: userJson);
      if (response.statusCode == 200) {
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  //? Edit user data
  Future<void> editUserData(UserModel user) async {
    try {
      final Map<String, dynamic> userJson = user.toJson();
      final response =
          await _dio.put("$_baseUrl/users/${user.id}.json", data: userJson);
      if (response.statusCode == 200) {
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  //? Get user data
  Future<Map<String, dynamic>> getUserData() async {
    // final userId = await FirebaseAuthenticationService().getUserInfo();
    print(1);
    // String userRealId =
    //     userId!['users'][0]['providerUserInfo']['federatedId'].toString();
    // print(userRealId);
    try {
      final response = await _dio.get("$_baseUrl/users/iser1.json");
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = response.data;
        return userData;
      }

      return {};
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get("$_baseUrl/users.json");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final users = data.entries.map((entry) {
          final retseptData = entry.value as Map<String, dynamic>;
          return UserModel.fromJson(retseptData);
        }).toList();
        return users;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  //? Add global path of retsept to user's local retsepts
  Future<void> addRetseptToUserLocal(String globalPath) async {
    const userId = '';
    try {
      await _dio.post(
        "$_baseUrl/users/$userId/retsepts.json",
        data: {'globalPath': globalPath},
      );
      // ignore: empty_catches
    } catch (e) {}
  }
}
