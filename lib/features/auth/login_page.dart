import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_system/features/auth/register_page.dart';
import '../../core/widgets/auth_split_layout.dart';
import '../../core/widgets/slide_page_route.dart';
import 'auth_provider.dart';
import '../places/place_list_page.dart';
import '../admin/admin_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;

  void _login() async {
    setState(() => _loading = true);
    final auth = ref.read(authServiceProvider);
    final error = await auth.signIn(
        _emailController.text.trim(), _passwordController.text.trim());
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      setState(() => _loading = false);
      return;
    }

    ref.invalidate(userRoleProvider);

    final role = await auth.getUserRole();
    if (role == 'admin') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AdminPage()),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PlaceListPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthSplitLayout(
      formFlex: 3,
      imageFlex: 7,
      formOnLeft: false,
      imageAsset: 'assets/logo2.png',
      form: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Welcome Back',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Login to your account', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),

          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _loading
              ? const CircularProgressIndicator()
              : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF5B5BD6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                SlidePageRoute(
                  page: const RegisterPage(),
                  direction: AxisDirection.right,
                ),
              );
            },
            child: const Text("Don't have an account? Register"),
          ),
        ],
      ),
    );
  }
}