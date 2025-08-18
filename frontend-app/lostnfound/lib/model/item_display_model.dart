class ItemDisplayModel {
  final String psid;
  final String title;
  final String place;
  final String tags;
  final String description;
  final String image;
  final String type;
  final String date_time;
  String status;

  ItemDisplayModel(
      {required this.psid,
      required this.title,
      required this.place,
      required this.tags,
      required this.description,
      required this.image,
      required this.type,
      required this.date_time,
      required this.status});
}

// post request
