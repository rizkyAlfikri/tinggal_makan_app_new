import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/check_setting_dark_theme_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/check_setting_restaurant_scheduler_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/save_setting_dark_theme_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/save_setting_restaurant_scheduler.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/settingbloc/scheduling_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/custom_dialog.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/platform_widget.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/settingPage';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    BlocProvider.of<CheckSettingDarkThemeBloc>(context).dispatch(NoParams());
    _checkRestaurantSchedulerSetting(context);
    super.initState();
  }

  void _checkDarkThemeSetting(BuildContext context) {
    BlocProvider.of<CheckSettingDarkThemeBloc>(context).dispatch(NoParams());
  }

  void _checkRestaurantSchedulerSetting(BuildContext context) {
    BlocProvider.of<CheckSettingRestaurantSchedulerBloc>(context)
        .dispatch(NoParams());
  }

  void _saveDarkThemeConfigSetting(BuildContext context, bool isEnable) {
    BlocProvider.of<SaveSettingDarkThemeBloc>(context).dispatch(isEnable);
  }

  void _saveRestaurantSchedulerConfigSetting(
      BuildContext context, bool isEnable) {
    BlocProvider.of<SaveSettingRestaurantSchedulerBloc>(context)
        .dispatch(isEnable);
  }

  void _executeSchedulingRestaurant(BuildContext context, bool isEnable) {
    BlocProvider.of<SchedulingBloc>(context).dispatch(isEnable);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            settingsText,
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: Colors.black),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildSettingList(context)));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(settingsText),
      ),
      child: Material(
        child: _buildSettingList(context),
      ),
    );
  }

  Widget _buildSettingList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<CheckSettingDarkThemeBloc, bool>(
          builder: (context, result) => SwitchListTile(
            title: Text(darkThemeText,
                style: Theme.of(context).textTheme.subtitle2),
            value: result,
            activeColor: secondaryColor,
            onChanged: (value) {
              _saveDarkThemeConfigSetting(context, value);
              _checkDarkThemeSetting(context);
            },
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        BlocBuilder<CheckSettingRestaurantSchedulerBloc, bool>(
          builder: (context, result) => SwitchListTile(
            title: Text(restaurantSchedulerText,
                style: Theme.of(context).textTheme.subtitle2),
            value: result,
            activeColor: secondaryColor,
            onChanged: (value) {
              setState(() {
                if (Platform.isAndroid) {
                  _saveRestaurantSchedulerConfigSetting(context, value);
                  _checkRestaurantSchedulerSetting(context);
                  _executeSchedulingRestaurant(context, value);
                } else {
                  customDialog(context);
                }
              });
            },
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
