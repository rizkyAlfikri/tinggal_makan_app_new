
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/setting_switch_data_factory.dart';
import 'package:tinggal_makan_app/feature/data/source/setting_switch_data_source.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/setting_switch_repository.dart';

import 'base/base_data_source_factory.dart';

class SettingSwitchRepositoryEntity extends SettingSwitchRespository {

  final SettingSwitchDataFactory _settingSwitchDataFactory;

  SettingSwitchRepositoryEntity(this._settingSwitchDataFactory);

  @override
  Future<Either<Failure, bool>> isSettingDarkThemeEnable() {
    return _createLocalData().isSettingDarkThemeEnable();
  }

  @override
  Future<Either<Failure, bool>> isSettingRestaurantSchedulerEnable() {
    return _createLocalData().isSettingRestaurantSchedulerEnable();
  }

  @override
  Future<Either<Failure, bool>> saveSettingDarkThemeEnable(bool isEnable) {
    return _createLocalData().saveSettingDarkThemeEnable(isEnable);
  }

  @override
  Future<Either<Failure, bool>> saveSettingRestaurantSchedulerEnable(bool isEnable) {
    return _createLocalData().saveSettingRestaurantSchedulerEnable(isEnable);
  }

  SettingSwitchDataSource _createLocalData(){
    return _settingSwitchDataFactory.createData(BaseDataSourceFactory.LOCAL);
  }
}