
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';

class GetRestaurantDetail implements UseCase<RestaurantDetailEntity, String>{

  final RestaurantsRepository _repository;

  GetRestaurantDetail(this._repository);

  @override
  Future<Either<Failure, RestaurantDetailEntity>> execute(String restaurantId)  {
    return _repository.getRetaurantDetail(restaurantId);
  }
}