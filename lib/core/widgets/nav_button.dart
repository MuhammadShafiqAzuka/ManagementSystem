import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const NavButton({
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFF5B5BD6) : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}