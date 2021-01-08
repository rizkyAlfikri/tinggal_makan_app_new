import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class RestaurantCity extends Equatable {
  final String city;
  final String image;

  RestaurantCity({@required this.city, @required this.image});

  @override
  List<Object> get props => [city, image];
}
