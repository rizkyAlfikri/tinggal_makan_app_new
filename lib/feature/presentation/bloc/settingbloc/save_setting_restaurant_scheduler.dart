import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/save_setting_restaurant_scheduler.dart';

class SaveSettingRestaurantSchedulerBloc extends Bloc<bool, bool>{

  final SaveSettingRestaurantScheduler _saveSettingRestaurantScheduler;

  SaveSettingRestaurantSchedulerBloc(this._saveSettingRestaurantScheduler);

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(bool event) async* {
  _saveSettingRestaurantScheduler.execute(event);
  }
}