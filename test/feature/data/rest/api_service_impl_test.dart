import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/feature/data/base/api_service.dart';
import 'package:tinggal_makan_app/feature/data/rest/api_service_impl.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_result.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_search_result.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_result.dart';

import '../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  ApiService apiService;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiService = ApisServiceImpl(mockHttpClient);
  });

  void stubHttpClientGetRestaurantListSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('restaurant_list'), 200));
  }

  void stubHttpClientGetRestaurantDetailSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('restaurant_detail'), 200));
  }

  void stubHttpClienGetRestaurantSearchSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('restaurant_search'), 200));
  }

  void stubHettpClientFailure() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("System Buys", 404));
  }

  group('getRestaurantList', () {
    test(
        'getRestaurantList with success code 200 should return list RestaurantEntity',
        () async {
      // arrange
      stubHttpClientGetRestaurantListSuccess200();
      final response = fixture('restaurant_list');
      final restaurantListMatcher =
          RestaurantsResult.fromJson(json.decode(response)).restaurants;

      // act
      final result = await apiService.getRestaurantsList();

      // assert
      verify(mockHttpClient.get(any));
      expect(result, restaurantListMatcher);
    });

    test('getRestaurantList with error code 404 should throw ServerException',
        () {
      // arrange
      stubHettpClientFailure();

      // act
      final result = apiService.getRestaurantsList();

      // act
      verify(mockHttpClient.get(any));
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRestaurantDetail', () {
    test(
        'getRestaurantDetail witch success code 200 should return RestaurantDetailEntity',
        () async {
      // arrange
      stubHttpClientGetRestaurantDetailSuccess200();
      String id = 'rqdv5juczeskfw1e867';
      final response = fixture('restaurant_detail');
      final restaurantDetailMatcher =
          RestaurantDetailResult.fromJson(jsonDecode(response)).restaurant;

      // act
      final result = await apiService.getRestaurantDetail(id);

      // assert
      verify(mockHttpClient.get(any));
      expect(result, restaurantDetailMatcher);
    });

    test('getRestaurantDetail with error code 404 should throw ServerException',
        () {
      // arrange
      String id = 'rqdv5juczeskfw1e867';
      stubHettpClientFailure();

      final result = apiService.getRestaurantDetail(id);

      // assert
      verify(mockHttpClient.get(any));
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getSearchRestaurants', () {
    test(
        'getSearchRestaurants with succes code 200 should return list RestaurantEntity',
        () async {
      // arrange
      String query = 'kafe';
      stubHttpClienGetRestaurantSearchSuccess200();
      final response = fixture('restaurant_search');
      final restaurantSearchMatcher =
          RestaurantSearchResult.fromJson(json.decode(response)).restaurants;

      // act
      final result = await apiService.getSearchRestaurants(query);

      // assert
      verify(mockHttpClient.get(any));
      expect(result, restaurantSearchMatcher);
    });

    test(
        ' getSearchRestaurant with error code 404 should throw ServerException',
        () {
      // arrange
      String query = 'kafe';
      stubHettpClientFailure();

      // act
      final result = apiService.getSearchRestaurants(query);

      // assert
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });
}
