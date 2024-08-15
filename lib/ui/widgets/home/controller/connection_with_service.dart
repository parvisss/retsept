import 'package:retsept_cherno/services/firestore/retsept/like_retsept.dart';

class ConnectionWithService {
  Future<int> handleLikeButton({
    required bool isLike,
    required String retseptId,
    required int likesLocal,
  }) async {
    // Update the likes locally
    likesLocal = isLike ? likesLocal + 1 : likesLocal - 1;

    // Send the like/unlike request to the server
    await LikeRetsept().likeRetsept(retseptId, isLike);

    // Get the updated likes count from the server
    final updatedLikes = await LikeRetsept().getNumberOfLikes(retseptId);

    return updatedLikes;
  }
}
