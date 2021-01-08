import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/save_setting_dark_theme.dart';

class SaveSettingDarkThemeBloc extends Bloc<bool, bool>{

  final SaveSettingDarkTheme _saveSettingDarkTheme;

  SaveSettingDarkThemeBloc(this._saveSettingDarkTheme);

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(bool event) async* {
  _saveSettingDarkTheme.execute(event);
  }

}