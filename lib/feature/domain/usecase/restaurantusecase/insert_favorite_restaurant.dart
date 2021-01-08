
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

class InsertFavoriteRestaurant extends  UseCase<bool, Restaurant>{

  final RestaurantsRepository _repository;

  InsertFavoriteRestaurant(this._repository);

  @override
  Future<Either<Failure, bool>> execute(Restaurant restaurant) {
    return _repository.insertRestaurant(restaurant);
  }
}