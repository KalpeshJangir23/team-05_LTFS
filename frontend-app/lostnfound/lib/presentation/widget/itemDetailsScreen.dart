import 'package:flutter/material.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:lostnfound/model/item_model.dart';

class ItemDetailScreen extends StatelessWidget {
  final ItemDisplayModel item;

  const ItemDetailScreen({super.key, required this.item});

  Future<void> _contactAdmin(BuildContext context) async {
    final email = Uri.encodeComponent('admin@lostnfoundLTFD.com');
    final subject = Uri.encodeComponent('Claiming Lost Item: ${item.title}');
    final body = Uri.encodeComponent(
        'Hello,\n\nI believe the following item belongs to me:\n\n'
        'Title: ${item.title}\nPlace: ${item.place}\nDescription: ${item.description}\n\n'
        'Please assist me in claiming it.\n\nThanks.');
    final url = 'mailto:$email?subject=$subject&body=$body';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open email app")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.image.isNotEmpty
                  ? Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      height: 220,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 220,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, size: 60),
                      ),
                    )
                  : Container(
                      height: 220,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported, size: 60),
                    ),
            ),
            const SizedBox(height: 20),

            // Title & Location
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              item.place,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Type & Status
            Row(
              children: [
                Chip(
                  label: Text(item.type),
                  backgroundColor: Colors.deepPurple.shade50,
                  labelStyle: TextStyle(color: Colors.deepPurple.shade800),
                ),
                const SizedBox(width: 10),
                Chip(
                  label: Text(item.status),
                  backgroundColor: Colors.green.shade50,
                  labelStyle: TextStyle(color: Colors.green.shade800),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tags
            if (item.tags.isNotEmpty) ...[
              Text(
                "Tags:",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: item.tags
                    .split(',')
                    .map((tag) => Chip(
                          label: Text(tag.trim()),
                          backgroundColor: Colors.blue.shade50,
                          labelStyle: TextStyle(color: Colors.blue.shade800),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],

            // Description
            Text(
              "Description",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              item.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Date & Time
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  item.date_time,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Contact Admin Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _contactAdmin(context),
                icon: const Icon(Icons.email),
                label: const Text("Contact Admin"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
