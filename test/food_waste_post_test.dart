import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';


void main() {
  test('Post created from Map should have appropriate property values', () {

    // first, setup
    final date = DateTime.parse('2022-08-09');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;


    // second, exercise
    final foodWastePost = FoodWastePost.fromJson({
      'date': date,
      'photoURL': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    // third, verify
    expect(foodWastePost.date, date);
    expect(foodWastePost.photoURL, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });
}