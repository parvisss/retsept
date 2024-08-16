import 'package:dio/dio.dart';
import 'package:user_repository/user_repostory.dart';

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
        print("User added successfully");
      } else {
        print("Failed to add user: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  //? Edit user data
  Future<void> editUserData(UserModel user) async {
    try {
      final Map<String, dynamic> userJson = user.toJson();
      final response =
          await _dio.put("$_baseUrl/users/${user.id}.json", data: userJson);
      if (response.statusCode == 200) {
        print("User data updated successfully");
      } else {
        print("Failed to update user data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  //? Get user data
  Future<Map<String, dynamic>> getUserData() async {
    final userId = '';

    try {
      final response = await _dio.get("$_baseUrl/users/$userId.json");
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = response.data;
        print("User data: $userData");
        return userData;
      }

      print("Failed to get user data: ${response.statusCode}");
      return {};
    } catch (e) {
      print("Error getting user data: $e");
      rethrow;
    }
  }

  //? Add global path of retsept to user's local retsepts
  Future<void> addRetseptToUserLocal(String globalPath) async {
    final userId = '';
    try {
      await _dio.post(
        "$_baseUrl/users/$userId/retsepts.json",
        data: {'globalPath': globalPath},
      );
      print('Global path added to user local retsepts');
    } catch (e) {
      print('Error adding global path to user local retsepts: $e');
    }
  }
}
