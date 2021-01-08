import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant_city.dart';

class GetRestaurantCity extends UseCase<List<RestaurantCity>, NoParams> {
  final RestaurantsRepository _repository;

  GetRestaurantCity(this._repository);

  @override
  Future<Either<Failure, List<RestaurantCity>>> execute(NoParams params) {
    return _repository.getRestaurantCities();
  }
}
