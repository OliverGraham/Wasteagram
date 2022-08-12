import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';


void main() {
  test('FoodWastePost created from Map '
      'should have appropriate property values', () {
    // first, setup
    final date = DateTime.parse('2022-08-09');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;


    // second, exercise
    final foodWastePost = FoodWastePost.fromJson({
      'date': date,
      'imageURL': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    // third, verify
    expect(foodWastePost.date, date);
    expect(foodWastePost.imageURL, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });


  test('Map created from FoodWastePost should have appropriate values', () {

    final date = DateTime.parse('2022-08-09');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    FoodWastePost fakePost = FoodWastePost(
      date: date,
      imageURL: url,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude
    );

    final fakeFirestoreDoc = fakePost.toJson();

    expect(fakeFirestoreDoc['date'], date);
    expect(fakeFirestoreDoc['imageURL'], url);
    expect(fakeFirestoreDoc['quantity'], quantity);
    expect(fakeFirestoreDoc['latitude'], latitude);
    expect(fakeFirestoreDoc['longitude'], longitude);
  });

}