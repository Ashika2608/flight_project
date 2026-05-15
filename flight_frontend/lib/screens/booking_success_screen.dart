import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../models/booking.dart';
import '../services/booking_storage.dart';
import 'booking_history_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Booking booking;

  const BookingSuccessScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1506012733851-46297839fa41?q=80&w=2031&auto=format&fit=crop"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.4)),

          Center(
            child: GlassmorphicContainer(
              width: 320,
              height: 480,
              borderRadius: 30,
              blur: 20,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1)
                ],
              ),
              borderGradient: LinearGradient(
                colors: [Colors.white54, Colors.white10],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.greenAccent, size: 70),
                    const SizedBox(height: 15),

                    Text(
                      "BOOKING CONFIRMED",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 30,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),

                    const Divider(color: Colors.white38, height: 30),

                    // Booking Details
                    infoRow("Passenger", booking.name),
                    infoRow("From", booking.from),
                    infoRow("To", booking.to),
                    infoRow("Date", booking.date),
                    infoRow("Seats", booking.seats),

                    const SizedBox(height: 30),
                    const Text(
                      "Have a safe journey!",
                      style: TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          // ✅ SAVE BOOKING
                          BookingStorage.bookings.add(booking);

                          // ✅ GO TO HISTORY
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BookingHistoryScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "VIEW HISTORY",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:",
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ],
      ),
    );
  }
}