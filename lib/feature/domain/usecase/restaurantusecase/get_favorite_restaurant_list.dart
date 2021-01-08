
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

class GetFavoriteRestaurantList extends UseCase<List<Restaurant>, NoParams>{

  final RestaurantsRepository _repository;

  GetFavoriteRestaurantList(this._repository);

  @override
  Future<Either<Failure, List<Restaurant>>> execute(NoParams params) {
    return _repository.getFavoriteRestaurantsList();
  }
}