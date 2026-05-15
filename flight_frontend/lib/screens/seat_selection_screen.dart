import 'package:flutter/material.dart';
import 'passenger_screen.dart'; // File name sariya irukanu check pannikonga

class SeatSelectionScreen extends StatefulWidget {
  final String from;
  final String to;
  const SeatSelectionScreen({super.key, required this.from, required this.to});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  // Selected seats list-ah track panna
  List<int> selectedSeats = [];

  // FEATURE: Logic-based Price Calculation
  // Interview-la idhai explain pannalaam: "Window seats calculate panni price add panren"
  int calculateTotal() {
    int total = 0;
    for (var seat in selectedSeats) {
      // Logic: Index 0 and 3 (and 4, 7...) are window seats (assuming 4 seats in a row)
      if (seat % 4 == 0 || (seat + 1) % 4 == 0) {
        total += 5000; // Window Seat Price
      } else {
        total += 4500; // Normal Seat Price
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Select Your Seat", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Price Info Header
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegend(Colors.orangeAccent, "Selected"),
                const SizedBox(width: 20),
                _buildLegend(Colors.white12, "Available"),
              ],
            ),
          ),
          const Text(
            "Window Seats: ₹5000 | Others: ₹4500", 
            style: TextStyle(color: Colors.white70, fontSize: 13)
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, 
                mainAxisSpacing: 15, 
                crossAxisSpacing: 15
              ),
              itemCount: 24, // Total seats
              itemBuilder: (context, index) {
                bool isSelected = selectedSeats.contains(index);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedSeats.remove(index);
                      } else {
                        selectedSeats.add(index);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orangeAccent : Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.white10,
                        width: 1
                      ),
                    ),
                    child: Icon(
                      Icons.event_seat, 
                      color: isSelected ? Colors.white : Colors.white38,
                      size: 28,
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Bar: Price and Navigation
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), 
                topRight: Radius.circular(30)
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)
              ]
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${selectedSeats.length} Seats Selected", 
                        style: const TextStyle(color: Colors.white54, fontSize: 14)
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Total: ₹ ${calculateTotal()}", 
                        style: const TextStyle(
                          color: Colors.greenAccent, 
                          fontSize: 22, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: selectedSeats.isEmpty ? null : () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => PassengerDetailsScreen(
                            from: widget.from, 
                            to: widget.to, 
                            totalAmount: calculateTotal()
                          )
                        )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      disabledBackgroundColor: Colors.white10,
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    child: const Text(
                      "NEXT", 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Legend builder for UI clarity
  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(width: 15, height: 15, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }
}