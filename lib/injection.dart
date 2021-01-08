import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tinggal_makan_app/core/network/network_info.dart';
import 'package:tinggal_makan_app/feature/data/base/api_service.dart';
import 'package:tinggal_makan_app/feature/data/rest/api_service_impl.dart';
import 'package:tinggal_makan_app/feature/data/restaurant_data_factory.dart';
import 'package:tinggal_makan_app/feature/data/restaurant_repository_entity.dart';
import 'package:tinggal_makan_app/feature/data/setting_switch_data_factory.dart';
import 'package:tinggal_makan_app/feature/data/setting_switch_repository_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/local/db/database_helper.dart';
import 'package:tinggal_makan_app/feature/data/source/local/db/database_helper_impl.dart';
import 'package:tinggal_makan_app/feature/data/source/local/local_restaurant_data.dart';
import 'package:tinggal_makan_app/feature/data/source/local/local_setting_switch_data.dart';
import 'package:tinggal_makan_app/feature/data/source/remote/remote_restaurant_data.dart';
import 'package:tinggal_makan_app/feature/data/source/setting_switch_data_source.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/restaurants_repository.dart';
import 'package:tinggal_makan_app/feature/domain/repositories/setting_switch_repository.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/delete_favorite_restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_favorite_restaurant_by_id.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_favorite_restaurant_list.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_city.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_detail.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_list.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_search.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/insert_favorite_restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/check_setting_dark_theme.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/check_setting_restaurant_scheduler.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/save_setting_dark_theme.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/settingusecase/save_setting_restaurant_scheduler.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/delete_favorite_restaurant_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/insert_favorite_restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restauran_detail_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_city_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_favorite_by_id_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_favorite_list_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_list_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_search_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/check_setting_dark_theme_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/check_setting_restaurant_scheduler_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/save_setting_dark_theme_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/save_setting_restaurant_scheduler.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/scheduling_bloc.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // Bloc
  sl.registerFactory(() => RestaurantListBloc(sl.get()));
  sl.registerFactory(() => RestaurantSearchBloc(sl.get()));
  sl.registerFactory(() => RestaurantCityBloc(sl.get()));
  sl.registerFactory(() => RestaurantDetailBloc(sl.get()));
  sl.registerFactory(() => RestaurantFavoriteByIdBloc(sl.get()));
  sl.registerFactory(() => RestaurantFavoriteListBloc(sl.get()));
  sl.registerFactory(() => InsertFavoriteRestaurantBloc(sl.get()));
  sl.registerFactory(() => DeleteFavoriteRestaurantBloc(sl.get()));
  sl.registerFactory(() => CheckSettingDarkThemeBloc(sl.get()));
  sl.registerFactory(() => CheckSettingRestaurantSchedulerBloc(sl.get()));
  sl.registerFactory(() => SaveSettingDarkThemeBloc(sl.get()));
  sl.registerFactory(() => SaveSettingRestaurantSchedulerBloc(sl.get()));
  sl.registerFactory(() => SchedulingBloc());

  // UseCase
  sl.registerLazySingleton(() => GetRestaurantList(sl.get()));
  sl.registerLazySingleton(() => GetRestaurantSearch(sl.get()));
  sl.registerLazySingleton(() => GetRestaurantDetail(sl.get()));
  sl.registerLazySingleton(() => GetRestaurantCity(sl.get()));
  sl.registerLazySingleton(() => GetFavoriteRestaurantById(sl.get()));
  sl.registerLazySingleton(() => GetFavoriteRestaurantList(sl.get()));
  sl.registerLazySingleton(() => InsertFavoriteRestaurant(sl.get()));
  sl.registerLazySingleton(() => DeleteFavoriteRestaurant(sl.get()));
  sl.registerLazySingleton(() => CheckSettingDarkTheme(sl.get()));
  sl.registerLazySingleton(() => CheckSettingRestaurantScheduler(sl.get()));
  sl.registerLazySingleton(() => SaveSettingDarkTheme(sl.get()));
  sl.registerLazySingleton(() => SaveSettingRestaurantScheduler(sl.get()));

  // Data Factory
  sl.registerLazySingleton(() => RestaurantDataFactory(
      networkInfo: sl.get(), apisService: sl.get(), databaseHelper: sl.get()));
  sl.registerLazySingleton(() => SettingSwitchDataFactory());

  // Repository
  sl.registerLazySingleton<RestaurantsRepository>(
      () => RestaurantRepositoryEntity(sl.get()));

  sl.registerLazySingleton(
      () => RemoteRestaurantData(apisService: sl.get(), networkInfo: sl.get()));

  sl.registerLazySingleton(() => LocalRestaurantData(sl.get()));

  sl.registerLazySingleton<SettingSwitchRespository>(
      () => SettingSwitchRepositoryEntity(sl.get()));

  sl.registerLazySingleton<SettingSwitchDataSource>(
      () => LocalSettingSwitchData());

  // Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl.get()));
  sl.registerLazySingleton<ApiService>(() => ApisServiceImpl(sl.get()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());

  // Database
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelperImpl());

}
