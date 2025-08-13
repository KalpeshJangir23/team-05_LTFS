import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String timeAgo;
  final bool claimed;
  final String description;
  final List<String> tags;
  final String location;

  const ItemDetailScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.claimed,
    required this.description,
    required this.tags,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: claimed ? Colors.green : Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(icon, size: 100, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Text("Location: $location", style: const TextStyle(fontSize: 16)),
            Text("Time Ago: $timeAgo", style: const TextStyle(fontSize: 16)),
            Text(
              "Status: ${claimed ? "Claimed" : "Unclaimed"}",
              style: TextStyle(
                fontSize: 16,
                color: claimed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              "Tags",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue.shade50,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
