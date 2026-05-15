class Flight {
  final String name;
  final String from;
  final String to;
  final int price;

  Flight({
    required this.name,
    required this.from,
    required this.to,
    required this.price,
  });
}

List<Flight> flightList = [
  Flight(name: "IndiGo", from: "Chennai", to: "Delhi", price: 4500),
  Flight(name: "Air India", from: "Mumbai", to: "Bangalore", price: 3800),
  Flight(name: "Vistara", from: "Hyderabad", to: "Kolkata", price: 5200),
];
