import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound/core/api_client.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:lostnfound/model/item_model.dart';
import 'package:lostnfound/services/auth/item_upload_repo.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return ItemRepository(apiClient.dio);
});

final postItemProvider =
    FutureProvider.family<void, ItemModel>((ref, item) async {
  final repo = ref.read(itemRepositoryProvider);
  await repo.postItem(item);
});

// FutureProvider to get item list
final getItemsProvider = FutureProvider<List<ItemDisplayModel>>((ref) async {
  final repository = ref.read(itemRepositoryProvider);
  return repository.getItems();
});

// Provider for updating item status
final updateItemStatusProvider =
    FutureProvider.family<void, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(itemRepositoryProvider);
  await repo.updateItemStatus(
    itemId: params['itemId'] as int,
    psid: params['psid'] as String,
    status: params['status'] as String,
    returnedToPsid: params['returnedToPsid'] as String?,
  );

  // Refresh the items provider to update the UI
  ref.invalidate(getItemsProvider);
});