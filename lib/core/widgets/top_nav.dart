import 'package:flutter/material.dart';
import 'package:management_system/core/widgets/slide_page_route.dart';
import 'package:management_system/features/auth/register_page.dart';
import 'package:management_system/features/landing/about_us_page.dart';
import 'package:management_system/features/landing/landing_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/landing/contact_us_page.dart';
import 'nav_button.dart';

enum NavPage { home, about, contact, login, signup }

class TopNav extends StatelessWidget {
  final NavPage currentPage;

  const TopNav({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'FNX',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),

        NavButton(
          label: 'Home',
          isActive: currentPage == NavPage.home,
          onTap: () => _go(context, const LandingPage(), NavPage.home),
        ),

        NavButton(
          label: 'About Us',
          isActive: currentPage == NavPage.about,
          onTap: () => _go(context, const AboutUsPage(), NavPage.about),
        ),

        NavButton(
          label: 'Contact Us',
          isActive: currentPage == NavPage.contact,
          onTap: () => _go(context, const ContactUsPage(), NavPage.contact),
        ),

        NavButton(
          label: 'Login',
          isActive: currentPage == NavPage.login,
          onTap: () => Navigator.push(
            context,
            SlidePageRoute(
              page: const LoginPage(),
              direction: AxisDirection.left,
            ),
          ),
        ),

        NavButton(
          label: 'SignUp',
          isActive: currentPage == NavPage.signup,
          onTap: () => Navigator.push(
            context,
            SlidePageRoute(
              page: const RegisterPage(),
              direction: AxisDirection.right,
            ),
          ),
        ),
      ],
    );
  }

  void _go(BuildContext context, Widget page, NavPage pageEnum) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}