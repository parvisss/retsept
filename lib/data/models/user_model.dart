// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String id;
  String name;
  String email;
  String password;
  List<dynamic> saved;
  List<dynamic> favorites;
  String image;
  String favoriteMeal;

  UserModel({

    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.saved,
    required this.favorites,
    required this.image,
    required this.favoriteMeal
  });

  // Factory method for creating an instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Method for converting an instance to a JSON map
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
