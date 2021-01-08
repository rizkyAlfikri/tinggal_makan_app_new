
import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/core/navigation/navigation.dart';
import 'package:tinggal_makan_app/core/notification/notification_helper.dart';
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
import 'package:tinggal_makan_app/feature/presentation/ui/setting_page.dart';
import 'package:tinggal_makan_app/injection.dart';

import 'feature/presentation/ui/home_page.dart';
import 'feature/presentation/ui/restaurant_detail_page.dart';
import 'feature/presentation/ui/restaurant_search_page.dart';
import 'feature/presentation/ui/splash_page.dart';
import 'feature/presentation/utils/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _backgroundService = BackgroundService();
  _backgroundService.initializeIsolate();

  if(Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantListBloc>(
            builder: (_) => sl<RestaurantListBloc>()),
        BlocProvider<RestaurantDetailBloc>(
          builder: (_) => sl<RestaurantDetailBloc>(),
        ),
        BlocProvider<RestaurantSearchBloc>(
            builder: (_) => sl<RestaurantSearchBloc>()),
        BlocProvider<RestaurantCityBloc>(
          builder: (_) => sl<RestaurantCityBloc>(),
        ),
        BlocProvider<RestaurantFavoriteListBloc>(
          builder: (_) => sl<RestaurantFavoriteListBloc>(),
        ),
        BlocProvider<RestaurantFavoriteByIdBloc>(
          builder: (_) => sl<RestaurantFavoriteByIdBloc>(),
        ),
        BlocProvider<InsertFavoriteRestaurantBloc>(
          builder: (_) => sl<InsertFavoriteRestaurantBloc>(),
        ),
        BlocProvider<DeleteFavoriteRestaurantBloc>(
          builder: (_) => sl<DeleteFavoriteRestaurantBloc>(),
        ),
        BlocProvider<CheckSettingRestaurantSchedulerBloc>(
          builder: (_) => sl<CheckSettingRestaurantSchedulerBloc>()
        ),
        BlocProvider<CheckSettingDarkThemeBloc>(
            builder: (_) => sl<CheckSettingDarkThemeBloc>()
        ),
        BlocProvider<SaveSettingRestaurantSchedulerBloc>(
            builder: (_) => sl<SaveSettingRestaurantSchedulerBloc>()
        ),
        BlocProvider<SaveSettingDarkThemeBloc>(
            builder: (_) => sl<SaveSettingDarkThemeBloc>()
        ),
        BlocProvider<SchedulingBloc>(
          builder: (_) => sl<SchedulingBloc>(),
        )
      ],
      child: MaterialPageApp(),
    );
  }
}

class MaterialPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primaryColor: secondaryColor,
          accentColor: accentColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          buttonTheme: ButtonThemeData(
            buttonColor: secondaryColor,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          appBarTheme: AppBarTheme(
              textTheme: myTextTheme.apply(bodyColor: Colors.black),
              elevation: 0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: secondaryColor,
              unselectedItemColor: Colors.grey)),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        HomePage.routeName: (context) => HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          ModalRoute.of(context).settings.arguments,),
        RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(
              initQuery: ModalRoute.of(context).settings.arguments,
            ),
        SettingPage.routeName: (context) => SettingPage(),
      },
    );
  }
}
