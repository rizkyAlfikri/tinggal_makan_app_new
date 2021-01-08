import 'package:tinggal_makan_app/core/network/network_info.dart';
import 'package:tinggal_makan_app/feature/data/source/local/db/database_helper.dart';
import 'package:tinggal_makan_app/feature/data/source/local/local_restaurant_data.dart';
import 'package:tinggal_makan_app/feature/data/source/remote/remote_restaurant_data.dart';
import 'package:tinggal_makan_app/feature/data/source/restaraunt_data_source.dart';

import 'base/api_service.dart';
import 'base/base_data_source_factory.dart';

class RestaurantDataFactory
    extends BaseDataSourceFactory<RestaurantDataSource> {
  final ApiService apisService;
  final NetworkInfo networkInfo;
  final DatabaseHelper databaseHelper;

  RestaurantDataFactory(
      {this.apisService, this.networkInfo, this.databaseHelper});

  @override
  RestaurantDataSource createData(String source) {
    return (source == BaseDataSourceFactory.LOCAL)
        ? LocalRestaurantData(databaseHelper)
        : RemoteRestaurantData(
            apisService: apisService, networkInfo: networkInfo);
  }
}
