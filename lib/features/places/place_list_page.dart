import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';
import '../auth/splash_page.dart';
import 'places_provider.dart';
import '../booking/booking_page.dart';
import '../booking/booking_provider.dart';

class PlaceListPage extends ConsumerWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesStreamProvider);
    final bookingsAsync = ref.watch(userBookingsStreamProvider);

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
      body: Column(
        children: [
          // User bookings
          Expanded(
            flex: 1,
            child: bookingsAsync.when(
              data: (bookings) {
                final userBookings = bookings;
                if (userBookings.isEmpty) {
                  return const Center(child: Text('No bookings yet'));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Your Bookings',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userBookings.length,
                        itemBuilder: (context, index) {
                          final booking = userBookings[index];
                          return ListTile(
                            title: Text('Place ID: ${booking['placeId']}'),
                            subtitle: Text(
                                'Date: ${booking['date'].split('T')[0]} | Status: ${booking['status']}'),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          const Divider(),
          // Available places
          Expanded(
            flex: 2,
            child: placesAsync.when(
              data: (places) {
                final placeList = places ?? [];
                if (placeList.isEmpty) {
                  return const Center(child: Text('No places available'));
                }

                return ListView.builder(
                  itemCount: placeList.length,
                  itemBuilder: (context, index) {
                    final place = placeList[index];
                    return Card(
                      child: ListTile(
                        title: Text(place.name),
                        subtitle:
                        Text('${place.location} • RM${place.pricePerDay}/day'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookingPage(place: place)),
                            );
                          },
                          child: const Text('Book'),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}