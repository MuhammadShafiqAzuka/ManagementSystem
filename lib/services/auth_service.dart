import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  // Expose authStateChanges stream
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // Login
  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Register
  Future<String?> register(String name, String email, String password, {String role = 'user'}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _db.collection('users').doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'role': role,
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Get role
  Future<String> getUserRole() async {
    if (_firebaseAuth.currentUser == null) return 'user';
    final doc = await _db.collection('users').doc(_firebaseAuth.currentUser!.uid).get();
    return doc.data()?['role'] ?? 'user';
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}