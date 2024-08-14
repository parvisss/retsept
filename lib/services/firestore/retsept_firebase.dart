import 'package:dio/dio.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/services/firestore/user_firestore.dart';

class RetseptFirebase {
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

  //? Edit retsept in global collection
  Future<void> editRetsept(String id, RetseptModel updatedRetsept) async {
    try {
      final Map<String, dynamic> retseptJson = updatedRetsept.toJson();
      final response =
          await _dio.put("$_baseUrl/retsepts/$id.json", data: retseptJson);

      if (response.statusCode == 200) {
        print('Retsept updated successfully');
      } else {
        print('Failed to update retsept: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating retsept: $e');
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
  Future<List<RetseptModel>> getRetsepts() async {
    print("getRetsept");
    try {
      final response = await _dio.get("$_baseUrl/retsepts.json");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final retseps = data.values.map((map) {
          return RetseptModel.fromJson(Map<String, dynamic>.from(map));
        }).toList();
        return retseps;
      } else {
        return [
          RetseptModel(
              dietaryTarget: "",
              difficulty: "",
              preparationTime: "",
              id: "1",
              name: "name",
              category: "category",
              ingredients: [],
              preparation: [],
              coments: [],
              likes: 10,
              image: "",
              video: "")
        ];
      }
    } catch (e) {
      return [
        RetseptModel(
            dietaryTarget: "",
            difficulty: "",
            preparationTime: "",
            id: "1",
            name: "name",
            category: "category",
            ingredients: [],
            preparation: [],
            coments: [],
            likes: 10,
            image: "",
            video: "")
      ];
    }
  }
}
