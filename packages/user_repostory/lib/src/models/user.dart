
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? password;
  final List<dynamic>? saved;
  final List<dynamic>? favorites;
  final String? image;
  final String? favoriteMeal;
  final double? rate;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.saved,
    this.favorites,
    this.image,
    this.favoriteMeal,
    this.rate,
  });

  static const empty = UserModel(
    id: '',
    name: '',
    email: '',
  );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        saved,
        favorites,
        image,
        favoriteMeal,
        rate,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      saved: json['saved'] as List<dynamic>?,
      favorites: json['favorites'] as List<dynamic>?,
      image: json['image'] as String?,
      favoriteMeal: json['favoriteMeal'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'saved': saved,
      'favorites': favorites,
      'image': image,
      'favoriteMeal': favoriteMeal,
      'rate': rate,
    };
  }
}