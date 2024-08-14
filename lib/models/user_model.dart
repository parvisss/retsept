// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String id;
  String name;
  String email;
  String password;
  List<dynamic> saved; // Use a more specific type if possible
  List<dynamic> favorites; // Use a more specific type if possible
  String image; // Store the file path as a string

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.saved,
    required this.favorites,
    required this.image, // Store the file path as a string
  });

  // Factory method for creating an instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Method for converting an instance to a JSON map
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
