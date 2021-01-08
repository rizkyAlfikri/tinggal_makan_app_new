import 'package:equatable/equatable.dart';

class RestaurantDetailEntity  extends Equatable {
  RestaurantDetailEntity({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Categorys> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  factory RestaurantDetailEntity.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Categorys>.from(
            json["categories"].map((x) => Categorys.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
    id,
    name,
    description,
    city,
    address,
    pictureId,
    categories,
    menus,
    rating,
    categories
  ];
}

class Categorys extends Equatable {
  Categorys({
    this.name,
  });

  final String name;

  factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  List<Object> get props => [name];
}

class CustomerReview extends Equatable{
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };

  @override
  List<Object> get props => [name, review, date];
}

enum Date { THE_13_NOVEMBER_2019, THE_15_DESEMBER_2020 }

class Menus extends Equatable{
  Menus({
    this.foods,
    this.drinks,
  });

  final List<Categorys> foods;
  final List<Categorys> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Categorys>.from(json["foods"].map((x) => Categorys.fromJson(x))),
        drinks: List<Categorys>.from(
            json["drinks"].map((x) => Categorys.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [foods, drinks];
}