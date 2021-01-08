import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tinggal_makan_app/core/common/asset_path.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_city_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_city_result.dart';
import 'package:tinggal_makan_app/feature/data/source/local/db/database_helper.dart';
import 'package:tinggal_makan_app/feature/data/source/restaraunt_data_source.dart';

class LocalRestaurantData implements RestaurantDataSource {
  final DatabaseHelper _databaseHelper;

  LocalRestaurantData(this._databaseHelper);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantSearch(
      String query) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantsList() async {
    try {
      final result = await _databaseHelper.getRestaurants();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RestaurantDetailEntity>> getRestaurantDetail(
      String restaurantId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RestaurantCityEntity>>> getRestaurantCities() {
    return _getRestaurantCities();
  }

  Future<Either<Failure, List<RestaurantCityEntity>>>
      _getRestaurantCities() async {
    try {
      final result = await rootBundle.loadString(restaurantCityJsonPath);
      final restaurantCities = parseRestaurantCity(result).restaurantCity;
      return Right(restaurantCities);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRestaurant(String id) async {
    try {
      _databaseHelper.deleteRestaurant(id);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(String id) async {
    try {
      final result = await _databaseHelper.getRestaurantById(id);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> insertRestaurant(
      RestaurantEntity restaurantEntity) async {
    try {
      _databaseHelper.insertRestaurant(restaurantEntity);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
