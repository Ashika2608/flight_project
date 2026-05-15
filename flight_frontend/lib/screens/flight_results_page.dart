import 'package:flutter/material.dart';
import 'booking_page.dart';

class FlightResultsPage extends StatelessWidget {
  const FlightResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Flights"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          flightCard(context, "Indigo", "₹4500"),
          flightCard(context, "Air India", "₹5200"),
          flightCard(context, "SpiceJet", "₹4800"),

        ],
      ),
    );
  }

  Widget flightCard(BuildContext context, String airline, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(airline),
        subtitle: const Text("Chennai → Delhi"),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BookingPage(airline: airline, price: price),
              ),
            );
          },
          child: const Text("Book"),
        ),
      ),
    );
  }
}