import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/check_setting_dark_theme.dart';

class CheckSettingDarkThemeBloc extends Bloc<NoParams, bool>{

  final CheckSettingDarkTheme _checkSettingDarkTheme;

  CheckSettingDarkThemeBloc(this._checkSettingDarkTheme);

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(NoParams event) async* {
    var result =  await _checkSettingDarkTheme.execute(event);

    yield result.fold((failure) => false, (data) => data);
  }

}