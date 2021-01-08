import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tinggal_makan_app/core/common/const.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant_city.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_city_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_list_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/ui/restaurant_search_page.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/platform_widget.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/restaurant_list_widget.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/sliver_appbar_delegate.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  String restaurantCityState = CityConstanta.ALL;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantListBloc>(context).dispatch(NoParams());
    BlocProvider.of<RestaurantCityBloc>(context).dispatch(NoParams());
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(body: _buildCustomScrollView(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _buildCustomScrollView(context));
  }

  Widget _buildCustomScrollView(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _buildHeaderAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  _buildRestaurantCityList(context),
                  SizedBox(
                    height: 16,
                  ),
                  _buildRestaurantList(context),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  SliverPersistentHeader _buildHeaderAppBar(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            minHeight: 120,
            maxHeight: 120,
            child: _buildAppBarContent(context)));
  }

  Widget _buildAppBarContent(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deliveringToText,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .apply(color: Colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                Wrap(children: [
                  Text(
                    currentLocationText,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(width: 36)
                ]),
                PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fromSize(
                        Rect.fromLTWH(140, 0, 0, 0), Size(100.0, 100.0)),
                    end: RelativeRect.fromSize(
                        Rect.fromLTWH(140, 8, 0, 0), Size(100.0, 100.0)),
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Curves.linear,
                  )),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: secondaryColor,
                    size: 24,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                      color: searchFieldColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                    onSubmitted: (value) {
                      Navigator.pushNamed(
                          context, RestaurantSearchPage.routeName,
                          arguments: value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 13),
                      prefixIcon: Icon(
                        Platform.isAndroid
                            ? Icons.search
                            : CupertinoIcons.search,
                        color: Colors.black,
                        size: 24,
                      ),
                      hintText: searchRestaurantsText,
                    ),
                  ),
                )),
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.sort,
                  size: 32,
                  color: secondaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantList(BuildContext context) {
    return BlocBuilder<RestaurantListBloc, RestaurantState>(
      builder: (context, result) {
        if (result is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (result is Empty) {
          return showErrorWidget(context, 'No Data');
        } else if (result is Error) {
          return showErrorWidget(context, result.message);
        } else if (result is HasData<List<Restaurant>>) {
          return (result.data.length > 0)
              ? Wrap(
                  children: result.data.filterByCity(restaurantCityState)
                      .map((restaurant) =>
                          RestaurantListWidget(restaurant: restaurant, isnNeedRefreshFavorite: false,))
                      .toList(),
                )
              : showErrorWidget(context, 'No Data');
        } else {
          return Center();
        }
      },
    );
  }

  Widget _buildRestaurantCityList(BuildContext context) {
    return BlocBuilder<RestaurantCityBloc, RestaurantState>(
        builder: (context, result) {
      if (result is Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (result is Empty) {
        return showErrorWidget(context, 'No Data');
      } else if (result is Error) {
        return showErrorWidget(context, result.message);
      } else if (result is HasData<List<RestaurantCity>>) {
        return (result.data.length > 0)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        chooseByCitiesText,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .apply(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 112,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              result.data != null ? result.data.length : 0,
                          itemBuilder: (context, index) =>
                              _buildRestaurantCityItem(
                                  context, result.data[index])),
                    )
                  ],
                ),
              )
            : showErrorWidget(context, 'No Data');
      } else {
        return Center();
      }
    });
  }

  Widget _buildRestaurantCityItem(
      BuildContext context, RestaurantCity restaurantCity) {
    return FlatButton(
      onPressed: () {
        setState(() {
          restaurantCityState = restaurantCity.city;
        });
      },
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
            width: 68,
            height: 68,
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 8,
              child: restaurantCity.image.isEmpty
                  ? Icon(Icons.public)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        restaurantCity.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              restaurantCity.city,
              style: Theme.of(context).textTheme.bodyText2.apply(
                  color: restaurantCityState == restaurantCity.city
                      ? Colors.blue
                      : Colors.black),
            ),
          )
        ],
      ),
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
