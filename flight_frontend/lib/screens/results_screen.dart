import 'package:flutter/material.dart';
import 'seat_selection_screen.dart'; // Seat selection screen link aaganum

class FlightResultsPage extends StatefulWidget {
  final String from;
  final String to;

  const FlightResultsPage({super.key, required this.from, required this.to});

  @override
  State<FlightResultsPage> createState() => _FlightResultsPageState();
}

class _FlightResultsPageState extends State<FlightResultsPage> {
  bool isLoading = true;

  // FEATURE: Multiple Flights with different timings and prices
  final List<Map<String, dynamic>> flights = [
    {"time": "10:00 AM", "airline": "IndiGo - 6E 213", "price": 4500},
    {"time": "02:30 PM", "airline": "Air India - AI 402", "price": 3800},
    {"time": "08:15 PM", "airline": "SpiceJet - SG 115", "price": 5200},
  ];

  @override
  void initState() {
    super.initState();
    // FEATURE: Realistic 2-second "Searching" delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("${widget.from} to ${widget.to}", style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading 
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.orangeAccent),
                SizedBox(height: 20),
                Text("Finding best deals...", style: TextStyle(color: Colors.white70)),
              ],
            ),
          )
        : ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              return _buildFlightCard(flights[index]);
            },
          ),
    );
  }

  Widget _buildFlightCard(Map<String, dynamic> flight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Glassmorphism style
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(flight['time'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(flight['airline'], style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
          Column(
            children: [
              Text("₹ ${flight['price']}", style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SeatSelectionScreen(from: widget.from, to: widget.to)
                  ));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                child: const Text("Book"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}