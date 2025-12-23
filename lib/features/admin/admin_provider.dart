import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/firebase_service.dart';

final adminProvider = Provider((ref) => FirebaseService());

final bookingsStreamProvider = StreamProvider.autoDispose((ref) {
  final service = ref.watch(adminProvider);
  return service.getBookings();
});