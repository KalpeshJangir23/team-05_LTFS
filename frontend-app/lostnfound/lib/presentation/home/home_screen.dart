import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/main/main_screen.dart';
import 'package:lostnfound/presentation/widget/form_field.dart';
import 'package:lostnfound/presentation/widget/itemCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            // Row with Lost and Found
            const SizedBox(height: 40),
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

            // List of items (you can add later)
            Text(
              "Recently Added",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 22),
            ),
            Expanded(
              child: ListView(
                children: const [
                  ItemCard(
                    icon: Icons.shopping_bag,
                    title: "Black handbag",
                    subtitle: "Student support",
                    timeAgo: "5 hours ago",
                    claimed: true,
                  ),
                  ItemCard(
                    icon: Icons.headphones,
                    title: "Black headphone",
                    subtitle: "Student activities",
                    timeAgo: "12 hours ago",
                    claimed: true,
                  ),
                  ItemCard(
                    icon: Icons.coffee,
                    title: "Tea mug",
                    subtitle: "BBS",
                    timeAgo: "1 day ago",
                    claimed: false,
                  ),
                ],
              ),
            ),

            const Spacer(),
            // Button to navigate to main screen
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
