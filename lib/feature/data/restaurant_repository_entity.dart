
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/restaurant_data_factory.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/restaraunt_data_source.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant_city.dart';

import 'base/base_data_source_factory.dart';

class RestaurantRepositoryEntity implements RestaurantsRepository{

  final RestaurantDataFactory _restaurantDataFactory;

  RestaurantRepositoryEntity(this._restaurantDataFactory);

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantSearch(String query) {
    return _createRemoteData().getRestaurantSearch(query);
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantsList() {
    return _createRemoteData().getRestaurantsList();
  }

  @override
  Future<Either<Failure, RestaurantDetailEntity>> getRetaurantDetail(String restaurantId) {
    return _createRemoteData().getRestaurantDetail(restaurantId);
  }

  @override
  Future<Either<Failure, List<RestaurantCity>>> getRestaurantCities() {
    return _createLocalData().getRestaurantCities();
  }

  @override
  Future<Either<Failure, bool>> deleteRestaurant(String id) {
    return _createLocalData().deleteRestaurant(id);
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurantsList() {
    return _createLocalData().getRestaurantsList();
  }

  @override
  Future<Either<Failure, Restaurant>> getRestaurantById(String id) {
    return _createLocalData().getRestaurantById(id);
  }

  @override
  Future<Either<Failure, bool>> insertRestaurant(Restaurant restaurant) {
    var result = mapTo(restaurant);
    return _createLocalData().insertRestaurant(result);
  }

  RestaurantDataSource _createRemoteData(){
    return _restaurantDataFactory.createData(BaseDataSourceFactory.REMOTE);
  }

  RestaurantDataSource _createLocalData(){
    return _restaurantDataFactory.createData(BaseDataSourceFactory.LOCAL);
  }

  RestaurantEntity mapTo ( Restaurant restaurant){
    return RestaurantEntity(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );
  }
}