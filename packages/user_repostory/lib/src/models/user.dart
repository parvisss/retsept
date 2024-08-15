class UserModel {
  String id;
  String name;
  String email;
  String? password;
  List<dynamic>? saved;
  List<dynamic>? favorites;
  String? image;
  String? favoriteMeal;
  double? rate;

  UserModel({
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

  List<Object?> get props =>
      [id, email, name, password, saved, favorites, image, favoriteMeal, rate];

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
