import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/place.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Place>> getPlaces() {
    return _db.collection('places').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => Place.fromJson(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> bookPlace(String placeId, String userId, DateTime date) async {
    await _db.collection('bookings').add({
      'placeId': placeId,
      'userId': userId,
      'date': date.toIso8601String(),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get all bookings
  Stream<List<Map<String, dynamic>>> getBookings() {
    return _db.collection('bookings')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList());
  }

  // Approve or reject booking
  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _db.collection('bookings').doc(bookingId).update({'status': status});
  }
}