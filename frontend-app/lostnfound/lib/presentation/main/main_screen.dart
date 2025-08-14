import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/item_model.dart';
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

  // Sample static data (replace with API results later)
  final List<ItemModel> lostItems = [
    ItemModel(
      psid: "PS101",
      title: "Black handbag",
      place: "Student support",
      tags: ["Bag", "Black", "Leather"].toString(),
      description:
          "A black handbag with leather finish found near Student Support.",
      image: "",
      type: "unclaimed",
    ),
    ItemModel(
      psid: "PS102",
      title: "Black headphone",
      place: "Student activities",
      tags: ["Electronics", "Black", "Wireless"].toString(),
      description: "A wireless headphone left in Student Activities Hall.",
      image: "",
      type: "claimed",
    ),
  ];

  final List<ItemModel> foundItems = [
    ItemModel(
      psid: "PS201",
      title: "iPhone 13",
      place: "Library",
      tags: ["Phone", "Apple", "White"].toString(),
      description: "White iPhone 13 found in the library reading area.",
      image: "",
      type: "unclaimed",
    ),
    ItemModel(
      psid: "PS202",
      title: "School backpack",
      place: "Cafeteria",
      tags: ["Bag", "School", "Blue"].toString(),
      description: "A blue school backpack found in the cafeteria.",
      image: "",
      type: "claimed",
    ),
  ];

  final List<ItemModel> claimedItems = [
    ItemModel(
      psid: "PS301",
      title: "Black handbag",
      place: "Claimed by Alice",
      tags: ["Bag", "Black", "Leather"].toString(),
      description: "Handbag was returned to Alice.",
      image: "",
      type: "claimed",
    ),
    ItemModel(
      psid: "PS302",
      title: "School backpack",
      place: "Claimed by Bob",
      tags: ["Bag", "School", "Blue"].toString(),
      description: "Backpack was claimed by Bob.",
      image: "",
      type: "claimed",
    ),
  ];

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
                  child: ListView.builder(
                      itemCount: lostItems.length,
                      itemBuilder: (context, index) {
                        return SizedBox();
                      }),
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
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: foundItems.length,
                //     itemBuilder: (context, index) {
                //       return ItemCard(item: foundItems[index]);
                //     },
                //   ),
                // ),
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
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: claimedItems.length,
                //     itemBuilder: (context, index) {
                //       return ItemCard(item: claimedItems[index]);
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
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
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 48),
                SizedBox(width: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
