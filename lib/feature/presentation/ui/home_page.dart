import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/notification/notification_helper.dart';
import 'package:tinggal_makan_app/feature/presentation/ui/restaurant_detail_page.dart';
import 'package:tinggal_makan_app/feature/presentation/ui/restaurant_page.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/background_service.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/platform_widget.dart';

import 'account_page.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homeRoute";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _backgroundService = BackgroundService();

  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    receivePort.listen((_) async => await _backgroundService.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  List<Widget> _listBottomNavWidget = [
    RestaurantPage(),
    FavoritePage(),
    AccountPage()
  ];

  List<BottomNavigationBarItem> _listBottomNavItem = [
    BottomNavigationBarItem(
        title: Text(restaurantText), icon: Icon(Icons.restaurant)),
    BottomNavigationBarItem(
        title: Text(favoriteText),
        icon: Icon(
            Platform.isAndroid ? Icons.favorite : CupertinoIcons.heart_solid)),
    BottomNavigationBarItem(
        title: Text(accountsText),
        icon:
            Icon(Platform.isAndroid ? Icons.settings : CupertinoIcons.settings))
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _listBottomNavWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _listBottomNavItem,
        currentIndex: _bottomNavIndex,
        elevation: 0,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _listBottomNavItem,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
      tabBuilder: (context, index) => _listBottomNavWidget[index],
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
