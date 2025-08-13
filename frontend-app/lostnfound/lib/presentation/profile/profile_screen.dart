import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/presentation/widget/itemCard.dart';
import 'package:lostnfound/presentation/widget/form_field.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String psNumber;

  // Example data for posted requests
  final List<Map<String, dynamic>> postedItems = [
    {
      "icon": Icons.laptop,
      "title": "Dell Laptop Bag",
      "subtitle": "Library",
      "timeAgo": "2 hours ago",
      "claimed": false,
      "category": "lost",
    },
    {
      "icon": Icons.phone_android,
      "title": "Samsung Phone",
      "subtitle": "Cafeteria",
      "timeAgo": "1 day ago",
      "claimed": true,
      "category": "found",
    },
  ];

  ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.psNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 20),
            Text(
              "My Posted Requests",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            ...postedItems.map(
              (item) => GestureDetector(
                onLongPress: () {
                  _showItemOptions(context, item);
                },
                child: ItemCard(
                  icon: item["icon"],
                  title: item["title"],
                  subtitle: item["subtitle"],
                  timeAgo: item["timeAgo"],
                  claimed: item["claimed"],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person, "Name", name),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.email, "Email", email),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.badge, "PS Number", psNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showItemOptions(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text("Update Request"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LostFoundForm(category: item["category"]),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete Request"),
              onTap: () {
                Navigator.pop(context);
                // TODO: implement delete logic
              },
            ),
          ],
        );
      },
    );
  }
}
