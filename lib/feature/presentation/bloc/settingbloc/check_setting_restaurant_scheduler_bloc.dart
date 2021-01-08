import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/check_setting_restaurant_scheduler.dart';

class CheckSettingRestaurantSchedulerBloc extends Bloc<NoParams, bool>{

  final CheckSettingRestaurantScheduler _checkSettingRestaurantScheduler;

  CheckSettingRestaurantSchedulerBloc(this._checkSettingRestaurantScheduler);

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(NoParams event) async* {
    var result =  await _checkSettingRestaurantScheduler.execute(event);
    yield result.fold((failure) => false, (data) => data);
  }
}