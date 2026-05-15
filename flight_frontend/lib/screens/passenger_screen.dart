import 'package:flutter/material.dart';
import 'payment_screen.dart'; // Make sure this file name is correct

class PassengerDetailsScreen extends StatefulWidget {
  final String from;
  final String to;
  final int totalAmount;

  const PassengerDetailsScreen({super.key, required this.from, required this.to, required this.totalAmount});

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("Passenger Details"), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey, // FEATURE: Form Key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter Primary Passenger Info", 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),
              
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white24)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.blueAccent)),
                ),
                // FEATURE: Validator logic
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your full name";
                  if (value.length < 3) return "Name must be at least 3 characters";
                  return null;
                },
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          from: widget.from, 
                          to: widget.to, 
                          passengerName: _nameController.text, 
                          amount: widget.totalAmount
                        )
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  child: const Text("PROCEED TO PAYMENT", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}