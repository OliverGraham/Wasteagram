import 'package:intl/intl.dart';

class FoodWastePost {

  DateTime date;
  String imageURL;
  int quantity;
  double? latitude;
  double? longitude;

  FoodWastePost({
    required this.date,
    required this.imageURL,
    required this.quantity,
    this.latitude = 0.0,
    this.longitude = 0.0
  });

  String getDate() {
    return _parseDate(date);
  }

  static String _parseDate(DateTime dateTime) {
    return DateFormat("EEEE, MMMM d, y").format(dateTime);
  }

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