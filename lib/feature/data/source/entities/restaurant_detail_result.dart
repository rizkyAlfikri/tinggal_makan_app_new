import 'dart:convert';

import 'restaurant_detail_entity.dart';

RestaurantDetailResult restaurantDetailResultFromJson(String str) => RestaurantDetailResult.fromJson(json.decode(str));

String restaurantDetailResultToJson(RestaurantDetailResult data) => json.encode(data.toJson());

class RestaurantDetailResult {
  RestaurantDetailResult({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  RestaurantDetailEntity restaurant;

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) => RestaurantDetailResult(
    error: json["error"],
    message: json["message"],
    restaurant: RestaurantDetailEntity.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}
