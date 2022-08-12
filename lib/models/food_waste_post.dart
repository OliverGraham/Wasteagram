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

  static const _longDateFormat = 'EEEE, MMMM d, y';
  static const _shortDateFormat = 'E, MMM d, y';

  String getDateForListScreen() {
    return DateFormat(_longDateFormat).format(date);
  }

  String getDateForDetailScreen() {
    return DateFormat(_shortDateFormat).format(date);
  }

  factory FoodWastePost.fromJson(Map<String, dynamic> json) => FoodWastePost(
      date: json['date'].toDate(),
      imageURL: json['imageURL'] as String,
      quantity: json['quantity'] as int,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double
  );

  Map<String, Object?> toJson() => {
    'date': date,
    'imageURL': imageURL,
    'quantity': quantity,
    'latitude': latitude,
    'longitude': longitude,
  };

}