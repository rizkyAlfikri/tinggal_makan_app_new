import 'dart:convert';

import 'restaurant_entity.dart';

RestaurantsResult restaurantsResultFromJson(String str) => RestaurantsResult.fromJson(json.decode(str));

String restaurantsResultToJson(RestaurantsResult data) => json.encode(data.toJson());

class RestaurantsResult {
  RestaurantsResult({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantEntity> restaurants;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) => RestaurantsResult(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<RestaurantEntity>.from(json["restaurants"].map((x) => RestaurantEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
