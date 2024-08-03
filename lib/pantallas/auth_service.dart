import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> authenticate() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      print('Error de autenticación: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
