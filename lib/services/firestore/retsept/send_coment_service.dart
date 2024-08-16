import 'package:dio/dio.dart';

class SendComentService {
  final Dio _dio = Dio();

  Future sendComent({
    required String retseptId,
    required String coment,
  }) async {
    try {
      final response = await _dio.get(
        "https://retsept-acd0d-default-rtdb.firebaseio.com/retsepts/$retseptId/coments.json",
      );
      final List resposeList = response.data;
      if (response.statusCode == 200) {
        // Handle case where data is a list

        final postResponse = await _dio.put(
          "https://retsept-acd0d-default-rtdb.firebaseio.com/retsepts/$retseptId/coments/${resposeList.length}.json",
          data: {
            'title': coment,
            'sender': "parviz",
            'date':
                "${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}"
          }, // Sending comment as a key-value pair
        );

        if (postResponse.statusCode == 200) {
          return resposeList.length;
        } else {
        }
      } else {
      }
    } catch (e) {
      rethrow;
    }
  }

  
}
