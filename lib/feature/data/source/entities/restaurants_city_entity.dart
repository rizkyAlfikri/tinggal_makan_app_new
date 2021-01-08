import 'package:tinggal_makan_app/feature/domain/restaurant_city.dart';

class RestaurantCityEntity extends RestaurantCity {
  RestaurantCityEntity({String city, String image})
      : super(city: city, image: image);

  factory RestaurantCityEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantCityEntity(
        city: json["city"] ?? '', image: json["image"] ?? '');
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["city"] = city;
    map["image"] = image;
    return map;
  }
}
