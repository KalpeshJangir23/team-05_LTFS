import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/Request/request_screen.dart';
import 'package:lostnfound/presentation/profile/profile_screen.dart'
    hide RequestScreen;
import 'package:lostnfound/presentation/widget/itemCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _lostSearchController = TextEditingController();
  final TextEditingController _foundSearchController = TextEditingController();
  final TextEditingController _claimedSearchController =
      TextEditingController();

  @override
  void dispose() {
    _lostSearchController.dispose();
    _foundSearchController.dispose();
    _claimedSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Lost, Found & Claimed
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Lost & Found Items",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppTheme.containerLost,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                      name: "John Doe",
                      email: "john.doe@example.com",
                      psNumber: "PS12345",
                    ),
                  ),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Lost"),
              Tab(text: "Found"),
              Tab(text: "Claimed"),
            ],
          ),
        ),

        // Main tab views
        body: TabBarView(
          children: [
            // LOST tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _lostSearchController,
                    decoration: AppInputDecoration.rounded(
                      hintText: "Search Lost Items...",
                    ),
                  ),
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
              ],
            ),

            // FOUND tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _foundSearchController,
                    decoration: AppInputDecoration.rounded(
                      hintText: "Search Found Items...",
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: const [
                      ItemCard(
                        icon: Icons.phone_iphone,
                        title: "iPhone 13",
                        subtitle: "Library",
                        timeAgo: "2 hours ago",
                        claimed: false,
                      ),
                      ItemCard(
                        icon: Icons.backpack,
                        title: "School backpack",
                        subtitle: "Cafeteria",
                        timeAgo: "6 hours ago",
                        claimed: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // CLAIMED tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _claimedSearchController,
                    decoration: AppInputDecoration.rounded(
                      hintText: "Search Claimed Items...",
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: const [
                      ItemCard(
                        icon: Icons.shopping_bag,
                        title: "Black handbag",
                        subtitle: "Claimed by Alice",
                        timeAgo: "Yesterday",
                        claimed: true,
                      ),
                      ItemCard(
                        icon: Icons.backpack,
                        title: "School backpack",
                        subtitle: "Claimed by Bob",
                        timeAgo: "2 days ago",
                        claimed: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // Floating center button
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.containerLost,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RequestScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.black),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // Bottom navigation bar
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SizedBox(width: 48), // left space
                SizedBox(width: 48), // right space
              ],
            ),
          ),
        ),
      ),
    );
  }
}
