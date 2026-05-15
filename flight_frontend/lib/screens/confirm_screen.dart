import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

// Intha import path unga project structure-ku yethamaari irukanum
import 'booking_screen.dart'; 

class FlightListScreen extends StatefulWidget {
  const FlightListScreen({super.key});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  // Backend API URL
  final String apiUrl = "http://localhost:8081/api/flights"; 

  Future<List<dynamic>> fetchFlights() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Backend check pannunga! Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1436491865332-7a61a109cc0f?q=80&w=2070&auto=format&fit=crop"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  "AVAILABLE FLIGHTS",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 35, 
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchFlights(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Colors.white));
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("${snapshot.error}", 
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70)),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No flights available", style: TextStyle(color: Colors.white)));
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var flight = snapshot.data![index];
                          String airlineName = flight['airline'] ?? "Airline";

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                // NAVIGATE TO BOOKING SCREEN
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingScreen(
                                      selectedAirline: airlineName, 
                                    ),
                                  ),
                                );
                              },
                              child: GlassmorphicContainer(
                                width: double.infinity,
                                height: 110,
                                borderRadius: 20,
                                blur: 15,
                                alignment: Alignment.center,
                                border: 1.5,
                                linearGradient: LinearGradient(
                                  colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)],
                                ),
                                borderGradient: LinearGradient(colors: [Colors.white24, Colors.white10]),
                                child: ListTile(
                                  leading: const Icon(Icons.flight_takeoff, color: Colors.blueAccent, size: 30),
                                  title: Text(airlineName.toUpperCase(), 
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                                  subtitle: Text("Flight: ${flight['flightNumber'] ?? 'N/A'}", 
                                    style: const TextStyle(color: Colors.white70)),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("₹${flight['price'] ?? '0'}", 
                                        style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                                      const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}