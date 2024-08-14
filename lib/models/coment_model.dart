import 'package:json_annotation/json_annotation.dart';

part 'coment_model.g.dart'; // This directive is for the generated file

@JsonSerializable() // This annotation indicates that this class is serializable
class ComentModel {
  String title;
  String date;
  String sender;

  ComentModel({
    required this.title,
    required this.date,
    required this.sender,
  });

  // Factory method to create an instance from a JSON map
  factory ComentModel.fromJson(Map<String, dynamic> json) =>
      _$ComentModelFromJson(json);

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$ComentModelToJson(this);
}
