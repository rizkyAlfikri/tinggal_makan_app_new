import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/source/setting_switch_data_source.dart';

class LocalSettingSwitchData implements SettingSwitchDataSource {
  static const _DARK_THEME_SWITCH = "dark_theme_switch";
  static const _DAILY_RESTAURANT_SWITCH = 'daily_restaurant_switch';

  @override
  Future<Either<Failure, bool>> isSettingDarkThemeEnable() async {
    try {
      final pref = await SharedPreferences.getInstance();
      var result = pref.getBool(_DARK_THEME_SWITCH) ?? false;
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSettingRestaurantSchedulerEnable() async {
    try {
      final pref = await SharedPreferences.getInstance();
      var result = pref.getBool(_DAILY_RESTAURANT_SWITCH) ?? false;
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveSettingDarkThemeEnable(
      bool isEnable) async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setBool(_DARK_THEME_SWITCH, isEnable);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveSettingRestaurantSchedulerEnable(
      bool isEnable) async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setBool(_DAILY_RESTAURANT_SWITCH, isEnable);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
