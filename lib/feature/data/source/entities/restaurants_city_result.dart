import 'dart:convert';

import 'restaurants_city_entity.dart';

class RestaurantsCityModel {
  List<RestaurantCityEntity> _restaurantCity;

  List<RestaurantCityEntity> get restaurantCity => _restaurantCity;

  RestaurantsCityModel({
    List<RestaurantCityEntity> restaurantCity}) {
    _restaurantCity = restaurantCity;
  }

  RestaurantsCityModel.fromJson(Map<String, dynamic> json) {
    if (json["restaurant_city"] != null) {
      _restaurantCity = [];
      json["restaurant_city"].forEach((v) {
        _restaurantCity.add(RestaurantCityEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_restaurantCity != null) {
      map["restaurant_city"] = _restaurantCity.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

RestaurantsCityModel parseRestaurantCity(String json) {
  if (json == null) {
    return null;
  }

  final dynamic parsed = jsonDecode(json);
  return RestaurantsCityModel.fromJson(parsed);
}
