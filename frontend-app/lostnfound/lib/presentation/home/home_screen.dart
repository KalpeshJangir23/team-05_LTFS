import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:lostnfound/presentation/main/main_screen.dart';
import 'package:lostnfound/presentation/widget/form_field.dart';
import 'package:lostnfound/presentation/widget/itemCard.dart';
import 'package:lostnfound/provider/item_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider for the item list
    final itemsAsync = ref.watch(getItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lost & Found",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppTheme.containerLost,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Lost & Found buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LostFoundForm(category: "lost"),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.containerLost,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Lost",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const LostFoundForm(category: "found"),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(left: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.containerFound,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Found",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Recently Added title
            Text(
              "Recently Added",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),

            // Recent items list
            Expanded(
              child: itemsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(child: Text("No items found."));
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        item: ItemDisplayModel(
                          psid: items[index].psid,
                          title: items[index].title,
                          place: items[index].place,
                          tags: items[index].tags,
                          description: items[index].description,
                          image: items[index].image,
                          type: items[index].type,
                          date_time: "",
                          status: items[index].status,
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Text("Error loading items: $err"),
                ),
              ),
            ),

            // Go to Main Screen button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.containerLost,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                  );
                },
                child: Text(
                  "Go to Main Screen",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
