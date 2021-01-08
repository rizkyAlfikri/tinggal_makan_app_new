import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinggal_makan_app/core/common/asset_path.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/delete_favorite_restaurant_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/insert_favorite_restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restauran_detail_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_favorite_by_id_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/platform_widget.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/sliver_appbar_delegate.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/restaurantDetailPage";
  final String idRestaurant;

  RestaurantDetailPage(this.idRestaurant);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    BlocProvider.of<RestaurantDetailBloc>(context)
        .dispatch(widget.idRestaurant);
    BlocProvider.of<RestaurantFavoriteByIdBloc>(context)
        .dispatch(widget.idRestaurant);
    controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _getDetailRestaurantData(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: Material(
        child: _getDetailRestaurantData(context),
      ),
    );
  }

  Widget _getDetailRestaurantData(BuildContext context) {
    return BlocBuilder<RestaurantDetailBloc, RestaurantState>(
      builder: (context, result) {
        if (result is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (result is Empty) {
          return showErrorWidget(context, 'No Data');
        } else if (result is Error) {
          return showErrorWidget(context, result.message);
        } else if (result is HasData<RestaurantDetailEntity>) {
          return _buildNestedScrollView(context, result.data);
        } else {
          return Center();
        }
      },
    );
  }

  Widget _buildNestedScrollView(
      BuildContext context, RestaurantDetailEntity restaurantDetail) {
    return NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [_buildSliverAppBar(context, restaurantDetail)];
        },
        body: Column(children: [
          _buildTabBar(context),
          Expanded(
              child: TabBarView(
            controller: controller,
            children: [
              _buildCustomScrollView(context, restaurantDetail),
              _buildRestaurantInfo(context, restaurantDetail),
              _buildRestaurantReview(context, restaurantDetail)
            ],
          )),
        ]));
  }

  Widget _buildSliverAppBar(
      BuildContext context, RestaurantDetailEntity restaurantDetail) {
    return SliverAppBar(
        pinned: true,
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            restaurantDetail.name,
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: Colors.white),
          ),
          titlePadding: const EdgeInsets.only(left: 56.0, bottom: 16.0),
          background: Hero(
            tag: restaurantDetail.pictureId,
            child: Image.network(
              restaurantDetail.pictureId.buildLargeImage(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: BlocBuilder<RestaurantFavoriteByIdBloc, Restaurant>(
                builder: (context, result) {
                 return IconButton(
                   icon: (result.id.isEmpty)
                   ? Icon((Platform.isAndroid)
                       ? Icons.favorite_border
                       : CupertinoIcons.heart)
                   : Icon((Platform.isAndroid)
                       ? Icons.favorite
                       : CupertinoIcons.heart_solid),
                   onPressed: () {
                       if(result.id.isEmpty){
                         var restaurant = restaurantDetail.mapToRestaurant();
                         BlocProvider.of<InsertFavoriteRestaurantBloc>(context)
                             .dispatch(restaurant);
                       } else {
                         BlocProvider.of<DeleteFavoriteRestaurantBloc>(context)
                             .dispatch(restaurantDetail.id);
                       }
                       BlocProvider.of<RestaurantFavoriteByIdBloc>(context)
                           .dispatch(restaurantDetail.id);
                   },
                 );
            }),
          )
        ]);
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.topCenter,
      child: TabBar(
        isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 24),
        controller: controller,
        tabs: <Widget>[
          Expanded(
            child: Tab(
              child: Row(
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    color: secondaryColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    menusText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Tab(
              child: Row(
                children: [
                  SvgPicture.asset(
                    aboutIconPath,
                    color: secondaryColor,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    aboutText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Tab(
              child: Row(
                children: [
                  SvgPicture.asset(
                    aboutIconPath,
                    color: secondaryColor,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Review",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomScrollView(
      BuildContext context, RestaurantDetailEntity restaurantDetail) {
    return CustomScrollView(
      slivers: [
        _buildHeaderMenu(context, foodsText),
        SliverList(
            delegate: SliverChildListDelegate(
                restaurantDetail.menus.foods != null
                    ? restaurantDetail.menus.foods
                        .map((food) => _buildMenuContent(context, food))
                        .toList()
                    : [Center(), Center()])),
        _buildHeaderMenu(context, drinksText),
        SliverList(
            delegate: SliverChildListDelegate(
                restaurantDetail.menus.drinks != null
                    ? restaurantDetail.menus.drinks
                        .map((drink) => _buildMenuContent(context, drink))
                        .toList()
                    : [Center(), Center()])),
      ],
    );
  }

  SliverPersistentHeader _buildHeaderMenu(BuildContext context, String title) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: SliverAppBarDelegate(
          minHeight: 56,
          maxHeight: 56,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, bottom: 8, top: 16),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          )),
    );
  }

  Widget _buildMenuContent(BuildContext context, Categorys category) {
    return Container(
      height: 120,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Icon(
                  Icons.fastfood,
                  size: 68,
                  color: secondaryColor,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              category.name,
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.favorite_border
                                  : CupertinoIcons.heart,
                              color: secondaryColor,
                              size: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("Healthy")],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: secondaryColor,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "4.5",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .apply(color: secondaryColor),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "(117 $ratingsText)",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(16),
                                    right: Radius.circular(16)),
                              ),
                              child: Text(
                                " $favoriteText ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo(
      BuildContext context, RestaurantDetailEntity restaurantDetail) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star,
                size: 24.0,
                color: secondaryColor,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                "${restaurantDetail.rating}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                Platform.isAndroid
                    ? Icons.location_on
                    : CupertinoIcons.location_solid,
                color: secondaryColor,
                size: 20,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                "${restaurantDetail.city}",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              restaurantDetail.address,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                aboutText,
                style: Theme.of(context).textTheme.subtitle1,
              )),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: Text(
            restaurantDetail.description,
            style: Theme.of(context).textTheme.bodyText1,
          )),
        ],
      ),
    );
  }

  Widget _buildRestaurantReview(
      BuildContext context, RestaurantDetailEntity restaurantDetail) {
    return ListView.builder(
        itemCount: restaurantDetail.customerReviews.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 48,
                ),
                title: Text(
                  '${restaurantDetail.customerReviews[index].name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subtitle: Text(
                  '${restaurantDetail.customerReviews[index].review}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
