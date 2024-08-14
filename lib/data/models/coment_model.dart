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
  factory ComentModel.fromJson(Map<String, dynamic> json) {
    return ComentModel(
      title: json['title'] as String,
      date: json['date'] as String,
      sender: json['sender'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'sender': sender,
    };
  }
}
