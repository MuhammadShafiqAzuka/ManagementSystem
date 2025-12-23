import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Stream of current user's bookings
final userBookingsStreamProvider = StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();

  return FirebaseFirestore.instance
      .collection('bookings')
      .where('userId', isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
});

// Function to book a place
final bookingProvider = Provider((ref) => BookingHelper());

class BookingHelper {
  final _bookingsRef = FirebaseFirestore.instance.collection('bookings');

  Future<void> bookPlace(String placeId, String userId, DateTime date) async {
    await _bookingsRef.add({
      'placeId': placeId,
      'userId': userId,
      'date': date.toIso8601String(),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}