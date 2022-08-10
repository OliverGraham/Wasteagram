
class FoodWastePost {

  DateTime date;
  String photoURL;
  int quantity;
  double latitude;
  double longitude;

  FoodWastePost({
    required this.date,
    required this.photoURL,
    required this.quantity,
    required this.latitude,
    required this.longitude
  });

  factory FoodWastePost.fromJson(Map<String, dynamic> json) => FoodWastePost(
      date: json['date'],
      photoURL: json['photoURL'],
      quantity: json['quantity'],
      latitude: json['latitude'],
      longitude: json['longitude']
  );

  Map<String, Object?> toJson() => {
    'date': date,
    'photoURL': photoURL,
    'quantity': quantity,
    'latitude': latitude,
    'longitude': longitude,
  };

}