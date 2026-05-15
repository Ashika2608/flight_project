import 'package:flutter/material.dart';
// Unga seat selection file name correct-ah irukanum
import 'seat_selection_screen.dart'; 

class Flight {
  final String flightNumber;
  final String airline;
  final String time;
  final int basePrice;

  Flight({required this.flightNumber, required this.airline, required this.time, required this.basePrice});
}

class FlightResultScreen extends StatefulWidget {
  final String from;
  final String to;

  const FlightResultScreen({super.key, required this.from, required this.to});

  @override
  State<FlightResultScreen> createState() => _FlightResultScreenState();
}

class _FlightResultScreenState extends State<FlightResultScreen> {
  // FEATURE 1: Loading Logic
  bool isLoading = true;

  // FEATURE 2: Dynamic Data (Multiple Flights with different prices)
  final List<Flight> availableFlights = [
    Flight(flightNumber: "6E-213", airline: "IndiGo", time: "10:00 AM", basePrice: 4500),
    Flight(flightNumber: "AI-402", airline: "Air India", time: "02:30 PM", basePrice: 3800),
    Flight(flightNumber: "SG-115", airline: "SpiceJet", time: "08:15 AM", basePrice: 5200),
  ];

  @override
  void initState() {
    super.initState();
    // 2 seconds "Searching" effect kaatum
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading 
        ? _buildLoadingState() // FEATURE: Shimmer/Loading UI
        : ListView.builder(
            itemCount: availableFlights.length,
            itemBuilder: (context, index) => _buildFlightCard(availableFlights[index]),
          ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.orangeAccent),
          SizedBox(height: 20),
          Text("Searching best flights...", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildFlightCard(Flight flight) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(flight.time, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text("${flight.airline} - ${flight.flightNumber}", style: const TextStyle(color: Colors.white54)),
          ]),
          Column(children: [
            Text("₹ ${flight.basePrice}", style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SeatSelectionScreen(from: widget.from, to: widget.to)
                ));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
              child: const Text("Book"),
            )
          ]),
        ],
      ),
    );
  }
}