import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/setting_switch_repository.dart';

class SaveSettingRestaurantScheduler extends UseCase<bool, bool>{

  final SettingSwitchRespository _respository;

  SaveSettingRestaurantScheduler(this._respository);

  @override
  Future<Either<Failure, bool>> execute(bool isEnable) {
    return _respository.saveSettingRestaurantSchedulerEnable(isEnable);
  }
}