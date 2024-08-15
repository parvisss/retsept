import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String idToken;
  final String email;
  final String refreshToken;
  final String expiresIn;
  final String localId;
  final bool registered;

  Auth({
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
    this.registered = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idToken': idToken});
    result.addAll({'email': email});
    result.addAll({'refreshToken': refreshToken});
    result.addAll({'expiresIn': expiresIn});
    result.addAll({'localId': localId});
    result.addAll({'registered': registered});

    return result;
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      idToken: map['idToken'] ?? '',
      email: map['email'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn'] ?? '',
      localId: map['localId'] ?? '',
      registered: map['registered'] ?? false,
    );
  }

  Auth copyWith({
    String? idToken,
    String? email,
    String? refreshToken,
    String? expiresIn,
    String? localId,
    bool? registered,
  }) {
    return Auth(
      idToken: idToken ?? this.idToken,
      email: email ?? this.email,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      localId: localId ?? this.localId,
      registered: registered ?? this.registered,
    );
  }

  @override
  List<Object?> get props => [
        idToken,
        email,
        refreshToken,
        expiresIn,
        localId,
        registered,
      ];
}