import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:lostnfound/presentation/widget/itemCard.dart';
import 'package:lostnfound/provider/auth_provider.dart';
import 'package:lostnfound/provider/item_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: const Center(child: Text("User not logged in")),
      );
    }

    // Use the items from getItemsProvider but only filter by user.psid
    final itemsAsync = ref.watch(getItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildProfileCard(user),
            const SizedBox(height: 20),
            Text(
              "My Posted Requests",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 8),
            itemsAsync.when(
              data: (items) {
                final myItems =
                    items.where((i) => i.psid == user.psid).toList();

                if (myItems.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("You have not posted any items yet."),
                  );
                }

                return Column(
                  children: myItems.map((item) {
                    return ItemCard(
                        item: ItemDisplayModel(
                      psid: item.psid ?? "",
                      title: item.title ?? "",
                      date_time: item.date_time ?? "",
                      status: item.status ?? "",
                      place: item.place ?? "",
                      tags: item.tags ?? "",
                      description: item.description ?? "",
                      image: item.image ?? "",
                      type: item.type ?? "",
                    ));
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Failed to load items: $e"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(user) {
    String displayName = (user.name.isNotEmpty) ? user.name : "Not provided";
    String displayEmail = (user.email.isNotEmpty) ? user.email : "Not provided";
    String displayPsid = (user.psid.isNotEmpty) ? user.psid : "Not provided";

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person, "Name", displayName),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.email, "Email", displayEmail),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.badge, "PS Number", displayPsid),
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
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 14)),
              const SizedBox(height: 4),
              Text(value.isNotEmpty ? value : "Not provided",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
