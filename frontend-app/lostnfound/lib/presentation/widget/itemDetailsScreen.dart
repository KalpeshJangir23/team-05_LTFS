import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lostnfound/model/item_model.dart';

class ItemDetailScreen extends StatelessWidget {
  final ItemModel item;

  const ItemDetailScreen({super.key, required this.item});

  Future<void> _contactAdmin(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'admin@lostnfound.com', // Replace with actual admin email
      queryParameters: {
        'subject': 'Claiming Lost Item: ${item.title}',
        'body':
            'Hello,\n\nI believe the following item belongs to me:\n\nTitle: ${item.title}\nPlace: ${item.place}\nDescription: ${item.description}\n\nPlease assist me in claiming it.\n\nThanks.'
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open email app")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.image.isNotEmpty
                  ? Image.network(item.image, fit: BoxFit.cover)
                  : Container(
                      height: 200,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
            ),
            const SizedBox(height: 16),

            // Title & Location
            Text(
              item.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              item.place,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Tags
            Wrap(
              spacing: 6,
              children: item.tags
                  .map((tag) => Chip(
                        label: Text(tag.toString()),
                        backgroundColor: Colors.blue.shade50,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              item.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Contact Admin Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _contactAdmin(context),
                icon: const Icon(Icons.email),
                label: const Text("Contact Admin"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
