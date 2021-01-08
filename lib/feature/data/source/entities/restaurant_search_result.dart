import 'dart:convert';

import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';

RestaurantSearchResult restaurantSearchResultFromJson(String str) => RestaurantSearchResult.fromJson(json.decode(str));

String restaurantSearchResultToJson(RestaurantSearchResult data) => json.encode(data.toJson());

class RestaurantSearchResult {
  RestaurantSearchResult({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantEntity> restaurants;

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) => RestaurantSearchResult(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<RestaurantEntity>.from(json["restaurants"].map((x) => RestaurantEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
