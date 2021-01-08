import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

class GetFavoriteRestaurantById extends UseCase<Restaurant, String>{

  final RestaurantsRepository _repository;

  GetFavoriteRestaurantById(this._repository);

  @override
  Future<Either<Failure, RestaurantEntity>> execute(String id) {
    return _repository.getRestaurantById(id);
  }
}