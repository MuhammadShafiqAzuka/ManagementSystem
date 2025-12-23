import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/place.dart';
import '../../services/firebase_service.dart';

final firebaseServiceProvider = Provider((ref) => FirebaseService());

final placesStreamProvider = StreamProvider<List<Place>>((ref) {
  final service = ref.watch(firebaseServiceProvider);
  return service.getPlaces();
});