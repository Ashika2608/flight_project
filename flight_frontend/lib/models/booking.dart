class Booking {
  final String name;
  final String from;
  final String to;
  final String date;
  final String seats;

  Booking({
    required this.name,
    required this.from,
    required this.to,
    required this.date,
    required this.seats,
  });

  // Convert object to Map (for Firebase later)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'from': from,
      'to': to,
      'date': date,
      'seats': seats,
    };
  }

  // Convert Map to object (for reading from database later)
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      name: map['name'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      date: map['date'] ?? '',
      seats: map['seats'] ?? '',
    );
  }
}
