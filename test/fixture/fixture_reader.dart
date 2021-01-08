import 'dart:io';

String fixture(String name) => File('test/fixture/$name.json').readAsStringSync();
String fixtureRestaurantCity() => File('assets/json/restaurants_city.json').readAsStringSync();