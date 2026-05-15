import 'dart:ui';
import 'package:flutter/material.dart';
import 'seat_selection_screen.dart';

class SeatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SeatSelectionScreen(),
                ),
              );
            },
            child: Text("Select Seat",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
