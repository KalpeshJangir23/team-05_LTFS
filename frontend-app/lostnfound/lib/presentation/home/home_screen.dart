import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/item_model.dart';
import 'package:lostnfound/presentation/main/main_screen.dart';
import 'package:lostnfound/presentation/widget/form_field.dart';
import 'package:lostnfound/presentation/widget/itemCard.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  // Sample recently added items
  final List<ItemModel> recentItems = [
    ItemModel(
      psid: "PS101",
      title: "Black handbag",
      place: "Student support",
      tags: ["Bag", "Black", "Leather"],
      description: "A black handbag found at the Student Support office.",
      image: "",
      type: "claimed",
    ),
    ItemModel(
      psid: "PS102",
      title: "Black headphone",
      place: "Student activities",
      tags: ["Electronics", "Headphones", "Black"],
      description: "Wireless black headphones found at Student Activities hall.",
      image: "",
      type: "claimed",
    ),
     ItemModel(
      psid: "PS103",
      title: "Tea mug",
      place: "BBS",
      tags: ["Mug", "Ceramic", "White"],
      description: "A ceramic tea mug left at BBS.",
      image: "",
      type: "unclaimed",
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                          builder: (_) =>
                              const LostFoundForm(category: "lost"),
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
              child: ListView.builder(
                itemCount: recentItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(item: recentItems[index]);
                },
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
