import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.token,
    this.refreshToken,
    this.expiresIn,
  });

  final String id;
  final String? email;
  final String? token;
  final String? refreshToken;
  final DateTime? expiresIn;

  @override
  List<Object?> get props => [id, email, token, refreshToken, expiresIn];

  static const empty = User(id: '');

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    if (email != null) result.addAll({'email': email});
    if (token != null) result.addAll({'token': token});
    if (refreshToken != null) result.addAll({'refreshToken': refreshToken});
    if (expiresIn != null) result.addAll({'expiresIn': expiresIn!.toIso8601String()});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'],
      token: map['idToken'],
      refreshToken: map['refreshToken'],
      expiresIn: map['expiresIn'] != null
          ? DateTime.parse(map['expiresIn'])
          : null,
    );
  }
}
