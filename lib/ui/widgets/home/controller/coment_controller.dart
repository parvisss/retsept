import 'package:retsept_cherno/services/firestore/retsept/send_coment_service.dart';

class ComentControllr {
  Future<int> sendConment(
      {required String retseptId, required String coment}) async {
    final count = await SendComentService()
        .sendComent(retseptId: retseptId, coment: coment);
    return count;
  }
}
