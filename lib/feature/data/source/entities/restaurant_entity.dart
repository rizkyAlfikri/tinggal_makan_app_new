import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

class RestaurantEntity extends Restaurant {
  RestaurantEntity({
    String id,
    String name,
    String description,
    String pictureId,
    String city,
    double rating,
  }) : super(
            id: id,
            name: name,
            description: description,
            pictureId: pictureId,
            city: city,
            rating: rating);

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) =>
      RestaurantEntity(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        pictureId: json["pictureId"] ?? '',
        city: json["city"] ?? '',
        rating: json["rating"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}