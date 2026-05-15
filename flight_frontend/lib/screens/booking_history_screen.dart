import 'package:flutter/material.dart';
import '../services/booking_storage.dart';
import '../models/booking.dart';
import 'booking_history_screen.dart';
class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Booking> bookings = BookingStorage.bookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Trips"),
        backgroundColor: Colors.blueAccent,
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                "No bookings yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("${booking.from} → ${booking.to}"),
                    subtitle: Text(
                      "Passenger: ${booking.name}\nSeat: ${booking.seats}\nDate: ${booking.date}",
                    ),
                    trailing: const Icon(Icons.flight),
                  ),
                );
              },
            ),
    );
  }
}