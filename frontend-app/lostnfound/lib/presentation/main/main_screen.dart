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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please log in to view profile')),
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
            final claimedItems = items
                .where((i) => i.status.toLowerCase() == 'returned')
                .toList();

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
    final query = controller.text.trim().toLowerCase();
    final filteredItems = items.where((item) {
      final titleMatch = item.title.toLowerCase().contains(query);
      final tagsMatch = item.tags.toLowerCase().contains(query);
      return titleMatch || tagsMatch;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Search $type Items by title or tags...",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (query) => setState(() {}),
          ),
        ),
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Text(
                    'No $type items found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) =>
                      ItemCard(item: filteredItems[index]),
                ),
        ),
      ],
    );
  }
}
