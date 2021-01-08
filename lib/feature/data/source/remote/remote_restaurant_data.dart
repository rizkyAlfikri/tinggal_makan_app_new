  import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/network/network_info.dart';
import 'package:tinggal_makan_app/feature/data/base/api_service.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_city_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/restaraunt_data_source.dart';

typedef Future<List<RestaurantEntity>> _ConcreteRestaurantResult();
typedef Future<List<RestaurantEntity>> _ConcreteRestaurantSearch();
typedef Future<RestaurantDetailEntity> _ConcreteRestaurantDetail();

class RemoteRestaurantData implements RestaurantDataSource {
  final ApiService apisService;
  final NetworkInfo networkInfo;

  RemoteRestaurantData(
      {@required this.apisService, @required this.networkInfo});

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantSearch(
      String query) async {
    return await _getRestaurantsSearchData(() {
      return apisService.getSearchRestaurants(query);
    });
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantsList() async {
    return await _getRestaurantsListData(() {
      return apisService.getRestaurantsList();
    });
  }

  @override
  Future<Either<Failure, RestaurantDetailEntity>> getRestaurantDetail(
      String restaurantId) async {
    return await _getRestaurantsDetailData(() {
      return apisService.getRestaurantDetail(restaurantId);
    });
  }

  @override
  Future<Either<Failure, List<RestaurantCityEntity>>> getRestaurantCities() {
    throw UnimplementedError();
  }

  Future<Either<Failure, List<RestaurantEntity>>> _getRestaurantsListData(
      _ConcreteRestaurantResult _concreteRestaurantResult) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await _concreteRestaurantResult();
        return Right(results);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, RestaurantDetailEntity>> _getRestaurantsDetailData(
      _ConcreteRestaurantDetail _concreteRestaurantDetail) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await _concreteRestaurantDetail();
        return Right(results);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<RestaurantEntity>>> _getRestaurantsSearchData(
      _ConcreteRestaurantSearch _concreteRestaurantSearch) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await _concreteRestaurantSearch();
        return Right(results);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRestaurant(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> insertRestaurant(RestaurantEntity restaurantEntity) {
    print('event remote ' + restaurantEntity.name);
    throw UnimplementedError();
  }

}
