import 'package:dio/dio.dart';
import 'package:retsept_cherno/models/retsept_model.dart';
import 'package:retsept_cherno/services/firestore/user_firestore.dart';

class RetseptFirestore {
  final String _baseUrl =
      "https://retsept-acd0d-default-rtdb.firebaseio.com"; // Base URL
  final Dio _dio = Dio();

  //? Add retsept to global collection
  Future<void> addRetsept(RetseptModel retsept) async {
    try {
      final Map<String, dynamic> retseptJson = retsept.toJson();
      final response =
          await _dio.post("$_baseUrl/retsepts.json", data: retseptJson);

      if (response.statusCode == 200) {
        print('Retsept added successfully');

        // Get the global path of the retsept

        // Add the global path to the user's local retsepts
        await UserFirestore().addRetseptToUserLocal("$_baseUrl/retsepts.json");
      } else {
        print('Failed to add retsept: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding retsept: $e');
    }
  }

  //? Delete retsept from global collection
  Future<void> deleteRetsept(String id) async {
    try {
      final response = await _dio.delete("$_baseUrl/retsepts/$id.json");
      if (response.statusCode == 200) {
        print("Retsept deleted successfully");
      } else {
        print("Failed to delete retsept: ${response.statusCode}");
      }
    } catch (e) {
      print("Error deleting retsept: $e");
    }
  }

  //? Stream of raw retsepts data from global collection
  Stream<List<Map<String, dynamic>>> getRawRetseptsStream() async* {
    while (true) {
      try {
        final response = await _dio.get("$_baseUrl/retsepts.json");
        if (response.statusCode == 200) {
          final retseptsMap = response.data as Map<String, dynamic>;
          final retseptsList = retseptsMap.entries.map((entry) {
            return entry.value as Map<String, dynamic>;
          }).toList();
          yield retseptsList;
        } else {
          print('Failed to fetch retsepts: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching retsepts: $e');
      }

      await Future.delayed(
        const Duration(seconds: 5),
      ); // Poll every 5 seconds to avoid error causing by number of requests
    }
  }
}
