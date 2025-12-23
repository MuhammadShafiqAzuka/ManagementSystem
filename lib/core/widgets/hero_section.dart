import 'package:flutter/material.dart';
import 'package:management_system/core/widgets/slide_page_route.dart';

import '../../features/auth/register_page.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // LEFT TEXT
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Event\n',
                      style: TextStyle(color: Color(0xFF5B5BD6)),
                    ),
                    TextSpan(
                      text: 'Management System',
                      style: TextStyle(color: Color(0xFF5B5BD6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Technology and future',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(
                width: 420,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                      'sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                      SlidePageRoute(
                        page: const RegisterPage(),
                        direction: AxisDirection.right,
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B5BD6),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get more',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        // RIGHT IMAGE
        Expanded(
          flex: 5,
          child: Image.asset(
            'assets/logo2.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
