import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_favorite_list_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/ui/restaurant_detail_page.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

class RestaurantListWidget extends StatelessWidget {

  final Restaurant restaurant;
  final bool isnNeedRefreshFavorite;

  RestaurantListWidget({this.restaurant, this.isnNeedRefreshFavorite});

  void _refreshFavoriteRestaurant(BuildContext context) {
    BlocProvider.of<RestaurantFavoriteListBloc>(context).dispatch(NoParams());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: () =>
            Navigator.of(context).pushNamed(
                RestaurantDetailPage.routeName,
                arguments: restaurant.id).then((value) {
              if (isnNeedRefreshFavorite) {
                _refreshFavoriteRestaurant(context);
              }
            }),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.pictureId.buildMediumImage(),
                  fit: BoxFit.fitWidth,
                  height: 180,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(restaurant.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6
                    .apply(color: Colors.black)),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Icon(
                    Icons.star,
                    size: 24.0,
                    color: secondaryColor,
                  ),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Flexible(
                  child: Text(
                    "${restaurant.rating}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  child: Icon(
                    Platform.isAndroid
                        ? Icons.location_on
                        : CupertinoIcons.location_solid,
                    color: secondaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "${restaurant.city}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
