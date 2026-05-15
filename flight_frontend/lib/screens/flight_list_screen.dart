import 'package:flutter/material.dart';

// ---------------------------------------------------------
// 1. FLIGHT SEARCH SCREEN
// ---------------------------------------------------------
class FlightListScreen extends StatefulWidget {
  const FlightListScreen({super.key});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  final List<String> cities = [
    'Chennai (MAA)', 'Mumbai (BOM)', 'Delhi (DEL)', 
    'Bangalore (BLR)', 'Coimbatore (CJB)', 'Madurai (IXM)',
    'Dubai (DXB)', 'Singapore (SIN)'
  ];

  String? fromCity;
  String? toCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://images.pexels.com/photos/2026324/pexels-photo-2026324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text("SKY BOOKING", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.black.withOpacity(0.8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: Colors.white12)),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            _buildCityPicker(Icons.flight_takeoff, "From", (val) => setState(() => fromCity = val)),
                            const Divider(color: Colors.white24, height: 40),
                            _buildCityPicker(Icons.flight_land, "To", (val) => setState(() => toCity = val)),
                            const SizedBox(height: 35),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (fromCity != null && toCity != null) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FlightResultScreen(from: fromCity!, to: toCity!)));
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                child: const Text("SEARCH FLIGHTS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityPicker(IconData icon, String label, Function(String) onSelected) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent, size: 28),
        const SizedBox(width: 15),
        Expanded(
          child: Autocomplete<String>(
            optionsBuilder: (value) => value.text.isEmpty ? const Iterable<String>.empty() : cities.where((city) => city.toLowerCase().contains(value.text.toLowerCase())),
            onSelected: onSelected,
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextField(
                controller: controller, focusNode: focusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white70), border: InputBorder.none),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 2. FLIGHT RESULTS SCREEN (PRICE DIFFERENTIATION ADDED)
// ---------------------------------------------------------
class FlightResultScreen extends StatelessWidget {
  final String from; final String to;
  FlightResultScreen({super.key, required this.from, required this.to});

  // Ippo rendu flight-kum vera vera rate kuduthuruken
  final List<Map<String, dynamic>> flightData = [
    {"name": "Indigo - 6E 213", "time": "10:00 AM", "price": 4500},
    {"name": "Air India - AI 101", "time": "02:30 PM", "price": 5200},
    {"name": "emirates - EK 101", "time": "02:30 PM", "price": 5200},


 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage("https://images.pexels.com/photos/1004584/pexels-photo-1004584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"), fit: BoxFit.cover))),
          Container(color: Colors.black.withOpacity(0.7)),
          SafeArea(
            child: Column(
              children: [
                AppBar(title: Text("$from to $to"), backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
                Expanded(
                  child: ListView.builder(
                    itemCount: flightData.length,
                    itemBuilder: (context, index) => _buildFlightCard(context, flightData[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightCard(BuildContext context, Map<String, dynamic> flight) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(flight['time'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(flight['name'], style: const TextStyle(color: Colors.white54)),
          ]),
          Text("₹ ${flight['price']}", style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeatSelectionScreen(from: from, to: to, basePrice: flight['price']))),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            child: const Text("Book"),
          )
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. SEAT SELECTION SCREEN (WINDOW CHARGE ADDED)
// ---------------------------------------------------------
class SeatSelectionScreen extends StatefulWidget {
  final String from; final String to; final int basePrice;
  const SeatSelectionScreen({super.key, required this.from, required this.to, required this.basePrice});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<int> selectedSeats = [];
  
  // Intha function seat type-a check panni price calculate pannum
  int calculateTotal() {
    int total = 0;
    for (int seatIndex in selectedSeats) {
      // Window seat logic (Example: Column 0 and 3 are window seats)
      if (seatIndex % 4 == 0 || seatIndex % 4 == 3) {
        total += widget.basePrice + 500; // Window seat extra 500
      } else {
        total += widget.basePrice;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AppBar(title: const Text("Select Seat (Window +₹500)"), backgroundColor: Colors.blueAccent),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: 24,
              itemBuilder: (context, index) {
                bool isSel = selectedSeats.contains(index);
                bool isWindow = (index % 4 == 0 || index % 4 == 3);
                return GestureDetector(
                  onTap: () => setState(() => isSel ? selectedSeats.remove(index) : selectedSeats.add(index)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSel ? Colors.orangeAccent : Colors.white12, 
                      borderRadius: BorderRadius.circular(8),
                      border: isWindow ? Border.all(color: Colors.blueAccent.withOpacity(0.5)) : null
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_seat, color: isSel ? Colors.white : (isWindow ? Colors.blueAccent : Colors.white24)),
                        if(isWindow) const Text("Win", style: TextStyle(color: Colors.blueAccent, fontSize: 8))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1E1E1E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ₹ ${calculateTotal()}", style: const TextStyle(color: Colors.greenAccent, fontSize: 20)),
                ElevatedButton(
                  onPressed: selectedSeats.isEmpty ? null : () => Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerDetailsScreen(from: widget.from, to: widget.to, totalAmount: calculateTotal()))),
                  child: const Text("NEXT"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. PASSENGER DETAILS SCREEN
// ---------------------------------------------------------
class PassengerDetailsScreen extends StatefulWidget {
  final String from; final String to; final int totalAmount;
  const PassengerDetailsScreen({super.key, required this.from, required this.to, required this.totalAmount});

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("Passenger Info"), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nameController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Full Name", labelStyle: TextStyle(color: Colors.white70))),
            const Spacer(),
            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(from: widget.from, to: widget.to, passengerName: _nameController.text, amount: widget.totalAmount)));
                }
              },
              child: const Text("PROCEED TO PAYMENT"),
            )),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. PAYMENT SCREEN
// ---------------------------------------------------------
class PaymentScreen extends StatefulWidget {
  final String from; final String to; final String passengerName; final int amount;
  const PaymentScreen({super.key, required this.from, required this.to, required this.passengerName, required this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isProcessing = false;

  void _processPayment() {
    setState(() => isProcessing = true);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BoardingPassScreen(from: widget.from, to: widget.to, passengerName: widget.passengerName)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Payment Gateway"), backgroundColor: Colors.blueAccent),
      body: isProcessing 
        ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(height: 20), Text("Processing Payment... Please wait.")]))
        : SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Payment Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.grey[100],
                  title: const Text("Total Amount to Pay"),
                  trailing: Text("₹ ${widget.amount}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                ),
                const SizedBox(height: 30),
                const Text("Enter Card Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildCardField("Card Number", "XXXX XXXX XXXX 1234", Icons.credit_card),
                const SizedBox(height: 15),
                Row(children: [
                  Expanded(child: _buildCardField("Expiry", "MM/YY", Icons.date_range)),
                  const SizedBox(width: 15),
                  Expanded(child: _buildCardField("CVV", "***", Icons.lock)),
                ]),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: const Text("PAY NOW", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildCardField(String label, String hint, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// ---------------------------------------------------------
// 6. BOARDING PASS SCREEN (FIXED BARCODE ERROR)
// ---------------------------------------------------------
class BoardingPassScreen extends StatelessWidget {
  final String from; final String to; final String passengerName;
  const BoardingPassScreen({super.key, required this.from, required this.to, required this.passengerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 80),
              const Text("Payment Successful!", style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("BOARDING PASS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Icon(Icons.flight, color: Colors.white)]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          _buildInfoCol("FROM", from.length > 3 ? from.substring(0,3).toUpperCase() : from),
                          const Icon(Icons.airplanemode_active, color: Colors.blueAccent),
                          _buildInfoCol("TO", to.length > 3 ? to.substring(0,3).toUpperCase() : to),
                        ]),
                        const SizedBox(height: 20),
                        _buildInfoCol("PASSENGER", passengerName.toUpperCase()),
                        const SizedBox(height: 20),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          _buildInfoCol("GATE", "A-01"),
                          _buildInfoCol("SEAT", "14B"),
                          _buildInfoCol("FLIGHT", "6E-213"),
                        ]),
                      ]),
                    ),
                    const Divider(height: 1, thickness: 1, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        // Fix: Using Placeholder instead of broken network image
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.barcode_reader, size: 40, color: Colors.black54)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), child: const Text("BACK TO HOME")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCol(String label, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold)),
      Text(value, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
    ]);
  }
}