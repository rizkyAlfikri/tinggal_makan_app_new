import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';

abstract class SettingSwitchDataSource {
  Future<Either<Failure, bool>> isSettingRestaurantSchedulerEnable();

  Future<Either<Failure, bool>> isSettingDarkThemeEnable();

  Future<Either<Failure, bool>> saveSettingRestaurantSchedulerEnable(bool isEnable);

  Future<Either<Failure, bool>> saveSettingDarkThemeEnable(bool isEnable);
}