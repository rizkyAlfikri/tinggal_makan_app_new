import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_city_entity.dart';

import 'entities/restaurant_detail_entity.dart';
import 'entities/restaurant_entity.dart';

abstract class RestaurantDataSource {
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantsList();

  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantSearch(
      String query);

  Future<Either<Failure, RestaurantDetailEntity>> getRestaurantDetail(
      String restaurantId);

  Future<Either<Failure, List<RestaurantCityEntity>>> getRestaurantCities();

  Future<Either<Failure, bool>> insertRestaurant(RestaurantEntity restaurantEntity);

  Future<Either<Failure, RestaurantEntity>> getRestaurantById(String id);

  Future<Either<Failure, bool>> deleteRestaurant(String id);
}
