import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user with email and password
  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during registration: $e");
      rethrow; // Forward the exception to handle it in the UI
    }
  }

  // Login user with email and password
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during login: $e");
      rethrow;
    }
  }

  // Logout the current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error during logout: $e");
      rethrow;
    }
  }

  // Get the current logged-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
