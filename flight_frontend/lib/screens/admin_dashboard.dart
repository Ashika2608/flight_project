import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context), // Go back to login
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "System Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Stats Row
            Row(
              children: [
                _buildStatCard("Total Flights", "124", Colors.blue),
                _buildStatCard("Bookings", "1,050", Colors.green),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard("Revenue", "\$45,200", Colors.orange),
                _buildStatCard("Users", "890", Colors.purple),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            
            // Action Buttons
            Expanded(
              child: ListView(
                children: [
                  _buildActionTile(Icons.add_box, "Add New Flight", "Schedule a new flight entry"),
                  _buildActionTile(Icons.people, "Manage Users", "View and edit user accounts"),
                  _buildActionTile(Icons.report, "View Reports", "Download monthly sales reports"),
                  _buildActionTile(Icons.settings, "System Settings", "Configure app parameters"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget for Statistic Cards
  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 5),
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Action Tiles
  Widget _buildActionTile(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.indigo, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Add logic for each action here
        },
      ),
    );
  }
}