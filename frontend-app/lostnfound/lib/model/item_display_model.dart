class ItemDisplayModel {
  final int id; // Changed to int to match backend Long
  final String psid;
  final String title;
  final String place;
  final String tags;
  final String description;
  final String image;
  final String type;
  final String dateTime; // Renamed for clarity
   String status;

  ItemDisplayModel({
    required this.id,
    required this.psid,
    required this.title,
    required this.place,
    required this.tags,
    required this.description,
    required this.image,
    required this.type,
    required this.dateTime,
    required this.status,
  });

  factory ItemDisplayModel.fromJson(Map<String, dynamic> json) {
    return ItemDisplayModel(
      id: json['id'] as int,
      psid: json['psid'] as String,
      title: json['itemName'] as String,
      place: json['place'] as String,
      tags: json['tags'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      type: json['type'] as String,
      dateTime: json['dateTime'] as String,
      status: json['status'] as String,
    );
  }
}
