import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

class GetRestaurantSearch implements UseCase<List<Restaurant>, String> {
  final RestaurantsRepository _repository;

  GetRestaurantSearch(this._repository);

  @override
  Future<Either<Failure, List<Restaurant>>> execute(String query) {
    return _repository.getRestaurantSearch(query);
  }
}
