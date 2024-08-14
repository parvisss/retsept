import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final controller = FirebaseAuth.instance;

  //!LOGIN
  Future<void> logIn(String email, String password) async {
    // to login we need user email and passowrd and use function "signInWithEmailAndPassword" which has 2 required parameters "password" ans "email"
    try {
      await controller.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  //! REGISTER
  Future<void> register(String name, String email, String password) async {
    //register by email and passowrd
    try {
      await controller.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  //!LOGOUT
  Future<void> logOut() async {
    // logout from current account on device
    await controller.signOut();
  }

  //? get current user id
  Future<String> getUserId() async {
    /// returns currnet users id
    return controller.currentUser!.uid.toString();
  }
}