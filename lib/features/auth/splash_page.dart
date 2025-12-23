import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import '../places/place_list_page.dart';
import '../admin/admin_page.dart';
import 'login_page.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // Not logged in → show login page
          return const LoginPage();
        } else {
          // Logged in → check role
          final roleAsync = ref.watch(userRoleProvider);
          return roleAsync.when(
            data: (role) {
              if (role == 'admin') return const AdminPage();
              return const PlaceListPage();
            },
            loading: () => const Scaffold(
                body: Center(child: CircularProgressIndicator())),
            error: (e, _) =>
                Scaffold(body: Center(child: Text('Error: $e'))),
          );
        }
      },
      loading: () =>
      const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}