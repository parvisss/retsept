class RetseptModel {
  final String id;
  final String name;
  final String category;
  final String dietaryTarget;
  final String difficulty;
  final String preparationTime;
  final List<String> ingredients;
  final List<String> preparation;
  final String description;
  final String preparer;
  final double rate;
  final int likes;
  final String image;
  final String video;
  final List<String> coments;

  RetseptModel({
    required this.id,
    required this.name,
    required this.category,
    required this.dietaryTarget,
    required this.difficulty,
    required this.preparationTime,
    required this.ingredients,
    required this.preparation,
    required this.description,
    required this.preparer,
    required this.rate,
    required this.likes,
    required this.image,
    required this.video,
    required this.coments,
  });

  // Factory constructor to create an instance from a JSON map
  factory RetseptModel.fromJson(Map<String, dynamic> json) {
    return RetseptModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      dietaryTarget: json['dietaryTarget'] ?? '',
      difficulty: json['difficulty'] ?? '',
      preparationTime: json['preparationTime'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      preparation: List<String>.from(json['preparation'] ?? []),
      description: json['description'] ?? '',
      preparer: json['preparer'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      likes: json['likes'] ?? 0,
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      coments: json['coments'] is List
          ? List<String>.from(json['coments'])
          : (json['coments'] as String).split('/'),
    );
  }

  // Method to convert an instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'dietaryTarget': dietaryTarget,
      'difficulty': difficulty,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'preparation': preparation,
      'description': description,
      'preparer': preparer,
      'rate': rate,
      'likes': likes,
      'image': image,
      'video': video,
      'coments': coments
          .join('/'), // Join the list into a string with '/' as the separator
    };
  }
}
