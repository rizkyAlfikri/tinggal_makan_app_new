import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';

abstract class DatabaseHelper {
  Future<void> insertRestaurant(RestaurantEntity restaurantEntity);

  Future<List<RestaurantEntity>> getRestaurants();

  Future<RestaurantEntity> getRestaurantById(String id);

  Future<void> deleteRestaurant(String id);
}
