import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/network/network_info.dart';
import 'package:tinggal_makan_app/feature/data/base/api_service.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_result.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_search_result.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_result.dart';
import 'package:tinggal_makan_app/feature/data/source/remote/remote_restaurant_data.dart';

import '../../../../fixture/fixture_reader.dart';

class MockApiService extends Mock implements ApiService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockApiService mockApiService;
  MockNetworkInfo mockNetworkInfo;
  RemoteRestaurantData restaurantData;

  setUp(() {
    mockApiService = MockApiService();
    mockNetworkInfo = MockNetworkInfo();
    restaurantData = RemoteRestaurantData(
        apisService: mockApiService, networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body) {
    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('Device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getRestaurantSearch', () {
    test('should check is device online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      restaurantData.getRestaurantSearch('kafe');

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'getRestaurantSearch with success should return list RestaurantEntity',
          () async {
        // arrange
        String query = 'kafe';
        final response = fixture('restaurant_search');
        final restaurantSearchMatcher =
            RestaurantSearchResult.fromJson(json.decode(response)).restaurants;

        when(mockApiService.getSearchRestaurants(query))
            .thenAnswer((_) => Future.value(restaurantSearchMatcher));

        // act
        final result = await restaurantData.getRestaurantSearch(query);

        // assert
        verify(mockApiService.getSearchRestaurants(query));
        expect(result, Right(restaurantSearchMatcher));
      });

      test('getRestaurantSearch with error ServerException should return ServerFailure', () async {
        // arrange
        String query = 'kafe';
        when(mockApiService.getSearchRestaurants(query))
            .thenThrow(ServerException());
        
        // act
        final result = await restaurantData.getRestaurantSearch(query);
        
        // assert
        verify(mockApiService.getSearchRestaurants(query));
        expect(result, Left(ServerFailure()));
      });
    });

    runTestOffline((){
      test('getRestaurantSearch with no Connection should return ConnectionFailure', () async {
        // arrange
        String query = 'kafe';

        // act
        final result = await restaurantData.getRestaurantSearch(query);

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });
    });
  });


  group('getRestaurantsList', () {
    test('should check is device online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      restaurantData.getRestaurantsList();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'getRestaurantsList with success should return list RestaurantEntity',
              () async {
            // arrange
            final response = fixture('restaurant_list');
            final restaurantListMatcher =
                RestaurantsResult.fromJson(json.decode(response)).restaurants;

            when(mockApiService.getRestaurantsList())
                .thenAnswer((_) => Future.value(restaurantListMatcher));

            // act
            final result = await restaurantData.getRestaurantsList();

            // assert
            verify(mockApiService.getRestaurantsList());
            expect(result, Right(restaurantListMatcher));
          });

      test('getRestaurantsList with error ServerException should return ServerFailure', () async {
        // arrange
        when(mockApiService.getRestaurantsList())
            .thenThrow(ServerException());

        // act
        final result = await restaurantData.getRestaurantsList();

        // assert
        verify(mockApiService.getRestaurantsList());
        expect(result, Left(ServerFailure()));
      });
    });

    runTestOffline((){
      test('getRestaurantsList with no Connection should return ConnectionFailure', () async {
        // arrange

        // act
        final result = await restaurantData.getRestaurantsList();

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });
    });
  });

  group('getRestaurantDetail', () {
    test('should check is device online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      restaurantData.getRestaurantDetail('rqdv5juczeskfw1e867');

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'getRestaurantDetail with success should return list RestaurantDetailEntity',
              () async {
            // arrange
            String id = 'rqdv5juczeskfw1e867';
            final response = fixture('restaurant_detail');
            final restaurantDetailMatcher =
                RestaurantDetailResult.fromJson(json.decode(response)).restaurant;

            when(mockApiService.getRestaurantDetail(id))
                .thenAnswer((_) => Future.value(restaurantDetailMatcher));

            // act
            final result = await restaurantData.getRestaurantDetail(id);

            // assert
            verify(mockApiService.getRestaurantDetail(id));
            expect(result, Right(restaurantDetailMatcher));
          });

      test('getRestaurantDetail with error ServerException should return ServerFailure', () async {
        // arrange
        String id = 'rqdv5juczeskfw1e867';
        when(mockApiService.getRestaurantDetail(id))
            .thenThrow(ServerException());

        // act
        final result = await restaurantData.getRestaurantDetail(id);

        // assert
        verify(mockApiService.getRestaurantDetail(id));
        expect(result, Left(ServerFailure()));
      });
    });

    runTestOffline((){
      test('getRestaurantDetail with no Connection should return ConnectionFailure', () async {
        // arrange
        String id = 'rqdv5juczeskfw1e867';

        // act
        final result = await restaurantData.getRestaurantDetail(id);

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });
    });
  });
}
