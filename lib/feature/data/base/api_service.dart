import '../source/entities/restaurant_detail_entity.dart';
import '../source/entities/restaurant_entity.dart';

abstract class ApiService {
  Future<List<RestaurantEntity>> getRestaurantsList();
  Future<RestaurantDetailEntity> getRestaurantDetail(String restaurantId);
  Future<List<RestaurantEntity>> getSearchRestaurants(String query);
}