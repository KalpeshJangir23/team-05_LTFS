import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:lostnfound/model/item_model.dart';

class ItemRepository {
  final Dio dio;

  ItemRepository(this.dio) {
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
  }

  // Fetch all items
  Future<List<ItemDisplayModel>> getItems() async {
    try {
      final response = await dio.get('/items'); // adjust endpoint
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data
            .map((json) => ItemDisplayModel(
                  id: json['id'],
                  psid: json['psid'].toString(),
                  title: json['itemName'] ?? '',
                  place: json['place'] ?? '',
                  tags: (json['tags'] as List<dynamic>?)?.join(', ') ?? '',
                  description: json['description'] ?? '',
                  image: json['image'] ?? '',
                  type: json['type'] ?? '',
                  dateTime: json['dateTime'] ?? '',
                  status: json['status'] ?? '',
                ))
            .toList();
      } else {
        throw Exception('Failed to fetch items: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching items: $e");
      rethrow;
    }
  }

  // Post an item with image
  Future<void> postItem(ItemModel item) async {
    try {
      MultipartFile? imageMultipart;

      if (item.image.isNotEmpty) {
        final file = File(item.image);
        if (!file.existsSync()) {
          throw Exception("Image file does not exist: ${item.image}");
        }
        imageMultipart = await MultipartFile.fromFile(
          item.image,
          filename: item.image.split('/').last,
        );
      }

      final formData = FormData.fromMap({
        "psid": item.psid,
        "place": item.place,
        "description": item.description,
        "itemName": item.title,
        "image": imageMultipart,
        "tags": item.tags,
        "handedToAdmin": item.handedToAdmin,
        "type": item.type,
      });

      print("-----------");
      print("Fields: ${formData.fields}");
      print("Files: ${formData.files}");
      print("-----------");

      final response = await dio.post(
        "/items", // make sure this matches your backend route
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      print("-----------");
      print("Response data: ${response.data}");
      print("Status code: ${response.statusCode}");
      print("-----------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Item posted successfully!");
      } else {
        throw Exception("Failed to post item: ${response.statusCode}");
      }
    } catch (e) {
      print("Error posting item: $e");
      rethrow;
    }
  }

  // Update item status (Admin only)
  Future<void> updateItemStatus({
    required int itemId,
    required String psid,
    required String status,
    String? returnedToPsid,
  }) async {
    try {
      final body = {
        'psid': psid,
        'status': status,
        if (returnedToPsid != null && returnedToPsid.isNotEmpty)
          'returnedToPsid': returnedToPsid,
      };

      final response = await dio.put(
        '/items/$itemId/status',
        data: body,
      );

      if (response.statusCode == 200) {
        print('Item status updated successfully!');
      } else {
        throw Exception('Failed to update item status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating item status: $e');
      rethrow;
    }
  }


    Future<void> updateItem(int id, String psid, Map<String, dynamic> updates) async {
    try {
      final response = await dio.put(
        '/items/$id',
        queryParameters: {'psid': psid},
        data: updates,
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update item: ${response.statusCode}');
      }
    } catch (e) {
      print("Error updating item: $e");
      rethrow;
    }
  }

  Future<void> deleteItem(int id, String psid) async {
    try {
      final response = await dio.delete(
        '/items/$id',
        queryParameters: {'psid': psid},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    } catch (e) {
      print("Error deleting item: $e");
      rethrow;
    }
  }
}
