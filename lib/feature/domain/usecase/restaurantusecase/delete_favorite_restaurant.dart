
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';

class DeleteFavoriteRestaurant extends UseCase<bool, String>{

  final RestaurantsRepository _repository;

  DeleteFavoriteRestaurant(this._repository);

  @override
  Future<Either<Failure, bool>> execute(String id) {
    return _repository.deleteRestaurant(id);
  }
}