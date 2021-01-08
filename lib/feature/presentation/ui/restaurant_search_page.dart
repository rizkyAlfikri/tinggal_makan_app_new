import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_search_bloc.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/platform_widget.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/restaurant_list_widget.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = "/searchRoute";

  final String initQuery;

  RestaurantSearchPage({this.initQuery});

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initQuery;
    BlocProvider.of<RestaurantSearchBloc>(context).dispatch(widget.initQuery);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 56, right: 16),
              child: SafeArea(child: _buildSearchField(context))),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildConsumerRestaurantSearch(context)));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Material(child: _buildSearchField(context)),
      ),
      child: Material(
        child: _buildConsumerRestaurantSearch(context),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    RestaurantSearchBloc restaurantSearchBloc =
        BlocProvider.of<RestaurantSearchBloc>(context);
    return Container(
      height: 32,
      decoration: BoxDecoration(
          color: searchFieldColor, borderRadius: BorderRadius.circular(16)),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) => restaurantSearchBloc.dispatch(value),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 13),
          prefixIcon: Icon(
            Platform.isAndroid ? Icons.search : CupertinoIcons.search,
            color: Colors.black,
            size: 24,
          ),
          hintText: searchRestaurantsText,
        ),
      ),
    );
  }

  Widget _buildConsumerRestaurantSearch(BuildContext context) {
    return BlocBuilder<RestaurantSearchBloc, RestaurantState>(
        builder: (context, result) {
          if(result is Loading) {
            return Center(child: CircularProgressIndicator(),);
          } else if (result is Empty) {
            return showErrorWidget(context, 'No Data');
          } else if (result is Error) {
            return showErrorWidget(context, result.message);
          } else if(result is HasData<List<Restaurant>>) {
            return ListView.builder(
                itemCount: result.data.length,
                itemBuilder: (context, index) {
                  return RestaurantListWidget(
                      restaurant: result.data[index], isnNeedRefreshFavorite: false,);
                });
          } else {
            return Center();
          }
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
