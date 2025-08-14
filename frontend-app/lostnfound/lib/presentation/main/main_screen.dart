import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:lostnfound/presentation/Request/request_screen.dart';
import 'package:lostnfound/presentation/profile/profile_screen.dart';
import 'package:lostnfound/presentation/widget/itemCard.dart';
import 'package:lostnfound/provider/auth_provider.dart';
import 'package:lostnfound/provider/item_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
    final itemsAsync = ref.watch(getItemsProvider);

    return DefaultTabController(
      length: 3,
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
                final authState = ref.read(authControllerProvider);
                final user = authState.user;

                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                } else {
                  // Optional: show a message if user is not logged in
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User not logged in')),
                  );
                }
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
        body: itemsAsync.when(
          data: (items) {
            final lostItems =
                items.where((i) => i.type.toLowerCase() == 'lost').toList();
            final foundItems =
                items.where((i) => i.type.toLowerCase() == 'found').toList();
            final claimedItems =
                items.where((i) => i.type.toLowerCase() == 'claimed').toList();

            return TabBarView(
              children: [
                buildItemList(lostItems, _lostSearchController, "Lost"),
                buildItemList(foundItems, _foundSearchController, "Found"),
                buildItemList(
                    claimedItems, _claimedSearchController, "Claimed"),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
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
          child: SizedBox(height: 56),
        ),
      ),
    );
  }

  Widget buildItemList(List<ItemDisplayModel> items,
      TextEditingController controller, String type) {
    final filteredItems = items
        .where((item) =>
            item.title.toLowerCase().contains(controller.text.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Search $type Items...",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (query) => setState(() {}),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) =>
                ItemCard(item: filteredItems[index]),
          ),
        ),
      ],
    );
  }
}
