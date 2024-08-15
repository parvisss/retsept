import 'package:dio/dio.dart';

class LikeRetsept {
  final Dio _dio = Dio();

  Future<void> likeRetsept(String retseptId, bool isLike) async {
    try {
      final response = await _dio.get<int>(
          "https://retsept-acd0d-default-rtdb.firebaseio.com/retsepts/$retseptId/likes.json");

      if (response.statusCode == 200) {
        int totalLikesParsed = int.parse(response.data.toString());

        final updatedLikes =
            isLike ? totalLikesParsed + 1 : totalLikesParsed - 1;

        final updateResponse = await _dio.patch(
          "https://retsept-acd0d-default-rtdb.firebaseio.com/retsepts/$retseptId/.json",
          data: {"likes": updatedLikes},
        );

        if (updateResponse.statusCode == 200) {
          print("Like granted!");
        } else {
          print("Error: couldn't update the like count.");
        }
      } else {
        print("Error: couldn't fetch the current like count.");
      }
    } catch (e) {
      print("Error on like: ($e)");
    }
  }

  Future<int> getNumberOfLikes(String retseptId) async {
    // this function helps to get the count of likes that i can save on local varible to avoid bugs
    try {
      final response = await _dio.get<int>(
          "https://retsept-acd0d-default-rtdb.firebaseio.com/retsepts/$retseptId/likes.json");
      return int.parse(response.data.toString());
    } catch (e) {
      rethrow;
    }
  }
}
