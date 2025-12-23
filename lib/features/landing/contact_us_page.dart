import 'package:flutter/material.dart';
import '../../core/widgets/top_nav.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
              TopNav(currentPage: NavPage.contact),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Us',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Have questions or feedback? We would love to hear from you! Reach out to us using any of the methods below:',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 24),

                      // Contact info
                      Row(
                        children: const [
                          Icon(Icons.email, color: Color(0xFF5B5BD6)),
                          SizedBox(width: 8),
                          Text('support@yourapp.com',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Icon(Icons.phone, color: Color(0xFF5B5BD6)),
                          SizedBox(width: 8),
                          Text('+1 234 567 890',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Color(0xFF5B5BD6)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '123 App Street, Tech City, Country',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      // Optional: Contact form
                      const Text(
                        'Send us a message:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Your Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Your Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Your Message',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFF5B5BD6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Send Message',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
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