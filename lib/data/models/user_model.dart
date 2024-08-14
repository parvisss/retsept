class UserModel {
  String id;
  String name;
  String email;
  String password;
  List<dynamic> saved;
  List<dynamic> favorites;
  String image;
  String favoriteMeal;
  double rate;

  UserModel({
    required this.id,
    required this.rate,
    required this.name,
    required this.email,
    required this.password,
    required this.saved,
    required this.favorites,
    required this.image,
    required this.favoriteMeal,
  });

  // Factory method to create an instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      rate: (json['rate'] as num).toDouble(),
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      saved: json['saved'] as List<dynamic>,
      favorites: json['favorites'] as List<dynamic>,
      image: json['image'] as String,
      favoriteMeal: json['favoriteMeal'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rate': rate,
      'name': name,
      'email': email,
      'password': password,
      'saved': saved,
      'favorites': favorites,
      'image': image,
      'favoriteMeal': favoriteMeal,
    };
  }
}
