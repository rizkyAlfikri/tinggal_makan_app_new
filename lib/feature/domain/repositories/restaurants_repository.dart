import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant_city.dart';

abstract class RestaurantsRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurantsList();

  Future<Either<Failure, List<Restaurant>>> getRestaurantSearch(String query);

  Future<Either<Failure, RestaurantDetailEntity>> getRetaurantDetail(String restaurantId);

  Future<Either<Failure, List<RestaurantCity>>> getRestaurantCities();

  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurantsList();

  Future<Either<Failure, bool>> insertRestaurant(Restaurant restaurant);

  Future<Either<Failure, Restaurant>> getRestaurantById(String id);

  Future<Either<Failure, bool>> deleteRestaurant(String id);
}