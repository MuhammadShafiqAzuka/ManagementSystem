import 'package:flutter/material.dart';
import '../../core/widgets/top_nav.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
              TopNav(currentPage: NavPage.about),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'About Us',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Welcome to our app! We are committed to delivering the best experience for our users. Our team consists of passionate professionals dedicated to providing top-quality services and products. We believe in innovation, collaboration, and customer satisfaction.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Our Mission:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'To create an intuitive and seamless platform that empowers our users to achieve their goals efficiently and enjoyably.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}