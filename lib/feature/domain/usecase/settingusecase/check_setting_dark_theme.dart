
import 'package:dartz/dartz.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/setting_switch_repository.dart';

class CheckSettingDarkTheme extends UseCase<bool, NoParams>{

  final SettingSwitchRespository _respository;

  CheckSettingDarkTheme(this._respository);

  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) {
    return _respository.isSettingDarkThemeEnable();
  }
}