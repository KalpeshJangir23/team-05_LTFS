class ItemModel {
  final String psid;
  final String title;
  final String place;
  final String tags;
  final String description;
  final String image; // store URL/path instead of raw image
  final String type;
  final bool handedToAdmin;

  ItemModel({
    required this.psid,
    required this.title,
    required this.place,
    required this.tags,
    required this.description,
    required this.image,
    required this.type,
    this.handedToAdmin = false,
  });

 Map<String, dynamic> toJson() {
    return {
      "psid": psid,
      "place": place,
      "description": description,
      "itemName": title,
      "tags": tags,
      "handedToAdmin": handedToAdmin,
      "type": type,
      // image is sent as MultipartFile in repository
    };
  }
}
