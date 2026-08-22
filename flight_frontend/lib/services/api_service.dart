import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://flight-project-ehf0.onrender.com/api/bookings";

  static Future<List<Map<String, dynamic>>> getBookings() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception("Failed to load bookings");
  }

  static Future<void> createBooking({
    required String passengerName,
    required String source,
    required String destination,
    required String seatType,
    required double price,
  }) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "passengerName": passengerName,
        "source": source,
        "destination": destination,
        "seatType": seatType,
        "price": price,
      }),
    );
  }
}
