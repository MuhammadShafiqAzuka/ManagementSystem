import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/place.dart';
import 'booking_provider.dart';

class BookingPage extends ConsumerStatefulWidget {
  final Place place;
  const BookingPage({super.key, required this.place});

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  DateTime? _selectedDate;

  void _bookPlace() async {
    if (_selectedDate == null) return;
    // Demo user
    const userId = 'demo-user';
    await ref.read(bookingProvider).bookPlace(widget.place.id, userId, _selectedDate!);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking submitted!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.place.name}')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toString().split(' ')[0]),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Book Now'),
              onPressed: _bookPlace,
            ),
          ],
        ),
      ),
    );
  }
}