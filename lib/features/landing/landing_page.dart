import 'package:flutter/material.dart';
import '../../core/widgets/hero_section.dart';
import '../../core/widgets/top_nav.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B5BD6),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              TopNav(currentPage: NavPage.home),
              const SizedBox(height: 40),
              Expanded(child: HeroSection()),
            ],
          ),
        ),
      ),
    );
  }
}