import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {

  final String flightName;
  final String price;

  const BookingPage({
    super.key,
    required this.flightName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Booking Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Flight Selected",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(
              "Flight : $flightName",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(
              "Price : $price",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Booking Successful ✈️"),
                    ),
                  );

                },
                child: const Text("Confirm Booking"),
              ),
            )

          ],
        ),
      ),
    );
  }
}