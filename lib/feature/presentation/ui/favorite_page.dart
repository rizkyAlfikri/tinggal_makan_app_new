import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_favorite_list_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/platform_widget.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/restaurant_list_widget.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            favoriteRestaurantText,
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: Colors.black),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildConsumerRestaurantFavorite(context)));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(favoriteRestaurantText),
      ),
      child: Material(
        child: _buildConsumerRestaurantFavorite(context),
      ),
    );
  }

  Widget _buildConsumerRestaurantFavorite(BuildContext context) {
    return BlocBuilder<RestaurantFavoriteListBloc, RestaurantState>(
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
        return ListView.builder(
            itemCount: result.data.length,
            itemBuilder: (context, index) {
              return RestaurantListWidget(
                  restaurant: result.data[index], isnNeedRefreshFavorite: true);
            });
      } else {
        return Center();
      }
    });
  }

  void _refreshFavoriteRestaurant() {
    BlocProvider.of<RestaurantFavoriteListBloc>(context).dispatch(NoParams());
  }

  @override
  Widget build(BuildContext context) {
    _refreshFavoriteRestaurant();
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
