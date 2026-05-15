import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/booking.dart';
import 'booking_success_screen.dart';

class BookingScreen extends StatefulWidget {
  final String? selectedAirline;

  const BookingScreen({super.key, this.selectedAirline});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedAirline != null) {
      fromController.text = widget.selectedAirline!;
    }
  }

  Widget buildGlassInput(TextEditingController controller, String label, IconData icon, {bool isNum = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
        ),
        validator: (value) => (value == null || value.isEmpty) ? "Required" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1542296332-2e4473faf563?q=80&w=2070&auto=format&fit=crop"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.6)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PASSENGER INFO", style: GoogleFonts.bebasNeue(fontSize: 40, color: Colors.white, letterSpacing: 2)),
                      const SizedBox(height: 25),
                      buildGlassInput(nameController, "Full Name", Icons.person),
                      buildGlassInput(fromController, "Airline", Icons.flight_takeoff),
                      buildGlassInput(toController, "Destination", Icons.location_on),
                      buildGlassInput(dateController, "Date (YYYY-MM-DD)", Icons.calendar_today),
                      buildGlassInput(seatsController, "Seats", Icons.chair, isNum: true),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Booking booking = Booking(
                                name: nameController.text,
                                from: fromController.text,
                                to: toController.text,
                                date: dateController.text,
                                seats: seatsController.text,
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSuccessScreen(booking: booking)));
                            }
                          },
                          child: const Text("CONFIRM BOOKING", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}