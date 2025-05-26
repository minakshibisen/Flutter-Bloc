import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    print(login);
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();
}
