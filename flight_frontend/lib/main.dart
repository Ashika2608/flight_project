import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/booking_history_screen.dart'; // ✅ add this

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flight App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),

      // ✅ initial screen
      home: const LoginScreen(),

      // ✅ routes add pannrom
      routes: {
        '/history': (context) => BookingHistoryScreen(),
      },
    );
  }
}