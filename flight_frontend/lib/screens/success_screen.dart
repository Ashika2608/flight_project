import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_storage.dart';
import 'home_screen.dart';
import 'booking_history_screen.dart';

class SuccessScreen extends StatelessWidget {
  final Booking booking;

  const SuccessScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A33),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 10),
            const Text(
              "Payment Successful!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(height: 30),

            // Boarding Pass UI
            Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text("BOARDING PASS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),

                  const SizedBox(height: 20),

                  infoRow("FROM", booking.from),
                  infoRow("TO", booking.to),
                  infoRow("PASSENGER", booking.name),
                  infoRow("SEAT", booking.seats),
                  infoRow("DATE", booking.date),

                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔥 VIEW HISTORY BUTTON
            ElevatedButton(
              onPressed: () {
                // ✅ SAVE BOOKING
                BookingStorage.bookings.add(booking);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingHistoryScreen(),
                  ),
                );
              },
              child: const Text("VIEW HISTORY"),
            ),

            const SizedBox(height: 10),

            // BACK TO HOME
            ElevatedButton(
              onPressed: () {
                // ✅ SAVE BOOKING (again safe)
                BookingStorage.bookings.add(booking);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text("BACK TO HOME"),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}