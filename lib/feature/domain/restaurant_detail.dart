import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class RestaurantDetail extends Equatable {
  RestaurantDetail({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.city,
    @required this.address,
    @required this.pictureId,
    @required this.categories,
    @required this.menus,
    @required this.rating,
    @required this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

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

class Menus extends Equatable {
  Menus({
    this.foods,
    this.drinks,
  });

  final List<Category> foods;
  final List<Category> drinks;

  Map<String, dynamic> toJson() =>
      {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [foods, drinks];
}

class Category extends Equatable {
  Category({
    this.name,
  });

  final String name;

  Map<String, dynamic> toJson() =>
      {
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

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "review": review,
        "date": date,
      };

  @override
  List<Object> get props => [name, review, date];
}
