import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/firebase_service.dart';

final bookingProvider = Provider((ref) => FirebaseService());