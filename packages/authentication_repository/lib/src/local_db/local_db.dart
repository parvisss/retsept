import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDb{
   static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<bool> checkIfLoggedIn() async {
    final String? token = await getIdToken();
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

 static Future<void> saveToken(String idToken) async {
    await secureStorage.write(key: "idToken", value: idToken);
  }

 static Future<String?> getIdToken() async {
    return await secureStorage.read(key: "idToken");
 }

 static Future<void> deleteToken() async {
    await secureStorage.delete(key: "idToken");
  }
}
