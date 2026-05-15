import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FlightScreen(),
    );
  }
}

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  List flights = [];

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/flights"),
    );

    if (response.statusCode == 200) {
      setState(() {
        flights = json.decode(response.body);
      });
    } else {
      print("Error fetching flights");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flights")),
      body: flights.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return Card(
                  child: ListTile(
                    title: Text(flight["name"]),
                    subtitle: Text(
                        "${flight["source"]} → ${flight["destination"]}"),
                  ),
                );
              },
            ),
    );
  }
}