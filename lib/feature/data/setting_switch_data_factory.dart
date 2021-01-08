
import 'package:tinggal_makan_app/feature/data/base/base_data_source_factory.dart';
import 'package:tinggal_makan_app/feature/data/source/local/local_setting_switch_data.dart';
import 'package:tinggal_makan_app/feature/data/source/setting_switch_data_source.dart';

class SettingSwitchDataFactory extends BaseDataSourceFactory<SettingSwitchDataSource>{

  @override
  SettingSwitchDataSource createData(String source) {
    if (source == BaseDataSourceFactory.LOCAL){
      return LocalSettingSwitchData();
    } else {
      throw UnimplementedError();
    }
  }
}