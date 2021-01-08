import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/background_service.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/date_time_utils.dart';

class SchedulingBloc extends Bloc<bool, bool> {
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(bool event) async* {
    if (event) {
      print('Scheduling Restaurant Active');
      yield await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeUtils.format(), exact: true, wakeup: true);
    } else {
      print('Scheduling Restaurant Canceled');
      yield await AndroidAlarmManager.cancel(1);
    }
  }
}
