import 'package:json_annotation/json_annotation.dart';
import 'coment_model.dart';

part 'retsept_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RetseptModel {
  String id;
  String name;
  String category;
  List<String> ingredients;
  List<String> preparation;
  List<ComentModel> coments;
  int likes;
  String image; // Store file path as a string
  String video; // Store file path as a string

  RetseptModel({
  
    required this.id,
    required this.name,
    required this.category,
    required this.ingredients,
    required this.preparation,
    required this.coments,
    required this.likes,
    required this.image,
    required this.video,
  });

  // Factory method for creating a new instance from a map
  factory RetseptModel.fromJson(Map<String, dynamic> json) =>
      _$RetseptModelFromJson(json);

  // Method for converting instance to map
  Map<String, dynamic> toJson() => _$RetseptModelToJson(this);
}
