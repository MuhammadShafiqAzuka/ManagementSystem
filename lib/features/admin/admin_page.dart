import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';
import '../auth/splash_page.dart';
import 'admin_provider.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(bookingsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
      body: bookingsAsync.when(
        data: (bookings) => ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return Card(
              child: ListTile(
                title: Text('Place ID: ${booking['placeId']}'),
                subtitle: Text(
                  'User: ${booking['userId']} | Date: ${booking['date'].split('T')[0]} | Status: ${booking['status']}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (booking['status'] == 'pending')
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => ref.read(adminProvider).updateBookingStatus(booking['id'], 'approved'),
                      ),
                    if (booking['status'] == 'pending')
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => ref.read(adminProvider).updateBookingStatus(booking['id'], 'rejected'),
                      ),
                  ],
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