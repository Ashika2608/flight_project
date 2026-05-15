import 'package:flutter/material.dart';
import 'booking_page.dart';

class FlightsList extends StatelessWidget {
  const FlightsList({super.key});

  @override
  Widget build(BuildContext context) {

    List flights = [
      {
        "name": "IndiGo",
        "time": "10:00 AM",
        "price": "₹4500"
      },
      {
        "name": "Air India",
        "time": "1:30 PM",
        "price": "₹5200"
      },
      {
        "name": "SpiceJet",
        "time": "6:45 PM",
        "price": "₹4100"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Flights"),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context, index) {

          var flight = flights[index];

          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 5,

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    flight["name"],
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Departure : ${flight["time"]}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Price : ${flight["price"]}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green),
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),

                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              flightName: flight["name"],
                              price: flight["price"],
                            ),
                          ),
                        );

                      },

                      child: const Text("Book"),
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}