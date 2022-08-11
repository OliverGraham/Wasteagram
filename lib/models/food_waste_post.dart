
class FoodWastePost {

  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  FoodWastePost({
    required this.date,
    required this.imageURL,
    required this.quantity,
    required this.latitude,
    required this.longitude
  });

  factory FoodWastePost.fromJson(Map<String, dynamic> json) => FoodWastePost(
      date: json['date'],
      imageURL: json['imageURL'],
      quantity: json['quantity'],
      latitude: json['latitude'],
      longitude: json['longitude']
  );

  Map<String, Object?> toJson() => {
    'date': date,
    'imageURL': imageURL,
    'quantity': quantity,
    'latitude': latitude,
    'longitude': longitude,
  };

}