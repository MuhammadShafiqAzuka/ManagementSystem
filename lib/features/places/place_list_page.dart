import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';
import '../auth/splash_page.dart';
import 'places_provider.dart';
import '../booking/booking_page.dart';
import '../../models/place.dart';

class PlaceListPage extends ConsumerWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SplashPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: placesAsync.when(
        data: (places) => ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return Card(
              child: ListTile(
                title: Text(place.name),
                subtitle: Text('${place.location} • RM${place.pricePerDay}/day'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingPage(place: place),
                      ),
                    );
                  },
                  child: const Text('Book'),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}