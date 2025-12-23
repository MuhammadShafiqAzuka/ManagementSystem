import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';

final authServiceProvider = Provider((ref) => AuthService());

// Stream of current Firebase user
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(authServiceProvider);
  return auth.authStateChanges();
});

// Provider to get the role of logged-in user
final userRoleProvider = FutureProvider<String>((ref) async {
  final auth = ref.watch(authServiceProvider);
  return auth.getUserRole();
});