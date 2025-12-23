import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/place.dart';
import '../auth/auth_provider.dart';
import 'booking_provider.dart';

class BookingPage extends ConsumerWidget {
  final Place place;
  const BookingPage({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> pickAndBookDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        helpText: 'Select booking date',
      );

      if (picked == null) return;

      final user = ref.read(authStateProvider).maybeWhen(
        data: (user) => user,
        orElse: () => null,
      );

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You must be logged in to book.')));
        return;
      }

      await ref.read(bookingProvider).bookPlace(place.id, user.uid, picked);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Booking submitted!')));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Book ${place.name}')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: const Text('Select Date & Book'),
          onPressed: pickAndBookDate,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(220, 50),
          ),
        ),
      ),
    );
  }
}