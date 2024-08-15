import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String idToken;
  final String email;
  final String localId;

  const Auth({
    required this.idToken,
    required this.email,
    required this.localId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idToken': idToken});
    result.addAll({'email': email});
    result.addAll({'localId': localId});

    return result;
  }

  static const empty = Auth(
    idToken: '',
    email: '',
    localId: '',
  );

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      idToken: map['idToken'] ?? '',
      email: map['email'] ?? '',
      localId: map['localId'] ?? '',
    );
  }

  factory Auth.fromList(List<dynamic> json, String? idToken) {
    return Auth(
      idToken: idToken ?? "",
      email: json.first['email'] ?? "",
      localId: json.first['localId'] ?? "",
    );
  }

  Auth copyWith({
    String? idToken,
    String? email,
    String? localId,
  }) {
    return Auth(
      idToken: idToken ?? this.idToken,
      email: email ?? this.email,
      localId: localId ?? this.localId,
    );
  }

  @override
  List<Object?> get props => [
        idToken,
        email,
        localId,
      ];
}
