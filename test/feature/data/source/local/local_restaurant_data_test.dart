
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_result.dart';
import 'package:tinggal_makan_app/feature/data/source/local/db/database_helper.dart';
import 'package:tinggal_makan_app/feature/data/source/local/local_restaurant_data.dart';

import '../../../../fixture/fixture_reader.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper{}

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  MockDatabaseHelper mockDatabaseHelper;

  LocalRestaurantData restaurantData;

  setUp((){
    mockDatabaseHelper = MockDatabaseHelper();
    restaurantData = LocalRestaurantData(mockDatabaseHelper);
  });

  group('getRestaurantsList', (){
    test('getRestaurantsList with success should return list RestaurantEntity', () async {
      // arrange
      final response = fixture('restaurant_list');
      final restaurantListMatcher =
          RestaurantsResult.fromJson(json.decode(response)).restaurants;

      when(mockDatabaseHelper.getRestaurants()).thenAnswer((_) async => restaurantListMatcher);

      // act
      final result = await restaurantData.getRestaurantsList();

      // assert
      verify(mockDatabaseHelper.getRestaurants());
      expect(result, Right(restaurantListMatcher));
    });

    test('getRestaurantsList with error CacheException should return CacheFailure', () async {
      // arrange
      when(mockDatabaseHelper.getRestaurants()).thenThrow(CacheException());

      // act
      final result = await restaurantData.getRestaurantsList();

      // assert
      verify(mockDatabaseHelper.getRestaurants());
      expect(result, Left(CacheFailure()));
    });
  });

  group('getRestaurantById', (){
    test('getRestaurantById with success should return RestaurantEntity', () async {
      // arrange
      String id = 'rqdv5juczeskfw1e867';
      final response = fixture('restaurant_list');
      final restaurantMatcher =
          RestaurantsResult.fromJson(json.decode(response)).restaurants.first;

      when(mockDatabaseHelper.getRestaurantById(id)).thenAnswer((_) async => restaurantMatcher);

      // act
      final result = await restaurantData.getRestaurantById(id);

      // assert
      verify(mockDatabaseHelper.getRestaurantById(id));
      expect(result, Right(restaurantMatcher));
    });

    test('getRestaurantById with error CacheException should return CacheFailure', () async {
      // arrange
      String id = 'rqdv5juczeskfw1e867';
      when(mockDatabaseHelper.getRestaurantById(id)).thenThrow(CacheException());

      // act
      final result = await restaurantData.getRestaurantById(id);

      // assert
      verify(mockDatabaseHelper.getRestaurantById(id));
      expect(result, Left(CacheFailure()));
    });
  });

  group('insertRestaurant', (){
    test('insertRestaurant with success should return true', () async {
      // arrange
      final response = fixture('restaurant_list');
      final restaurant =
          RestaurantsResult.fromJson(json.decode(response)).restaurants.first;

      when(mockDatabaseHelper.insertRestaurant(restaurant)).thenAnswer((_) async => true);

      // act
      final result = await restaurantData.insertRestaurant(restaurant);

      // assert
      verify(mockDatabaseHelper.insertRestaurant(restaurant));
      expect(result, Right(true));
    });

    test('insertRestaurant with error CacheException should return CacheFailure', () async {
      // arrange
      final response = fixture('restaurant_list');
      final restaurant =
          RestaurantsResult.fromJson(json.decode(response)).restaurants.first;
      when(mockDatabaseHelper.insertRestaurant(restaurant)).thenThrow(CacheException());

      // act
      final result = await restaurantData.insertRestaurant(restaurant);

      // assert
      verify(mockDatabaseHelper.insertRestaurant(restaurant));
      expect(result, Left(CacheFailure()));
    });
  });

  group('deleteRestaurant', (){
    test('deleteRestaurant with success should return true', () async {
      // arrange
      String id = 'rqdv5juczeskfw1e867';
      when(mockDatabaseHelper.deleteRestaurant(id)).thenAnswer((_) async => true);

      // act
      final result = await restaurantData.deleteRestaurant(id);

      // assert
      verify(mockDatabaseHelper.deleteRestaurant(id));
      expect(result, Right(true));
    });

    test('deleteRestaurant with error CacheException should return CacheFailure', () async {
      // arrange
      String id = 'rqdv5juczeskfw1e867';
      when(mockDatabaseHelper.deleteRestaurant(id)).thenThrow(CacheException());

      // act
      final result = await restaurantData.deleteRestaurant(id);

      // assert
      verify(mockDatabaseHelper.deleteRestaurant(id));
      expect(result, Left(CacheFailure()));
    });
  });
}