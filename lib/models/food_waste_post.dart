
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

  static fromMap(Map<String, Object> map) {
    return FoodWastePost(
        date: map['date'] as DateTime,
        photoURL: map['photoURL'] as String,
        quantity: map['quantity'] as int,
        latitude: map['latitude'] as double,
        longitude: map['longitude'] as double
    );
  }


}