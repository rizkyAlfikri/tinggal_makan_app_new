import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tinggal_makan_app/core/common/const.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/feature/data/base/api_service.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_result.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_search_result.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurants_result.dart';

class ApisServiceImpl implements ApiService {
  static final int _successStatusCode = 200;

  final http.Client client;

  ApisServiceImpl(this.client);

  @override
  Future<List<RestaurantEntity>> getRestaurantsList() async {
    final response = await client.get(baseUrl + list);
    if (response.statusCode == _successStatusCode) {
      return RestaurantsResult.fromJson(jsonDecode(response.body)).restaurants;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RestaurantDetailEntity> getRestaurantDetail(
      String restaurantId) async {
    final response = await client.get(baseUrl + detail + restaurantId);
    if (response.statusCode == _successStatusCode) {
      return RestaurantDetailResult.fromJson(json.decode(response.body))
          .restaurant;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RestaurantEntity>> getSearchRestaurants(String query) async {
    final response = await client.get(baseUrl + search + query);
    if (response.statusCode == _successStatusCode) {
      return RestaurantSearchResult.fromJson(json.decode(response.body))
          .restaurants;
    } else {
      throw ServerException();
    }
  }
}
