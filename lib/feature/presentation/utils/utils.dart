import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinggal_makan_app/core/common/const.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';
import 'package:tinggal_makan_app/core/error/failure.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

void setStatusBarColor(Color colors) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: colors,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark
  )
  );
}

Widget showErrorWidget(BuildContext context, String message) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Platform.isAndroid ? Icons.do_not_disturb_on : CupertinoIcons
            .clear_circled, color: secondaryLightColor, size: 72,),
        SizedBox(height: 24,),
        Text(message, textAlign: TextAlign.center, style: Theme
            .of(context)
            .textTheme
            .headline6
            .apply(color: Colors.black,),)
      ],
    ),
  );
}

extension BuildImageUrl on String{
  String buildSmallImage() => "$baseUrl/$imageSmall/$this";
  String buildMediumImage() => "$baseUrl/$imageMedium/$this";
  String buildLargeImage() => "$baseUrl/$imageLarge/$this";

}

extension FilterRetaurant on List<Restaurant> {
  List<Restaurant> filterByCity(String restaurantCityState) {
    switch (restaurantCityState) {
      case CityConstanta.ACEH:
        return _filter(this, CityConstanta.ACEH);
        break;
      case CityConstanta.BALI:
        return _filter(this, CityConstanta.BALI);
        break;
      case CityConstanta.BALIKPAPAN:
        return _filter(this, CityConstanta.BALIKPAPAN);
        break;
      case CityConstanta.GORONTALO:
        return _filter(this, CityConstanta.GORONTALO);
        break;
      case CityConstanta.MEDAN:
        return _filter(this, CityConstanta.MEDAN);
        break;
      case CityConstanta.SURABAYA:
        return _filter(this, CityConstanta.SURABAYA);
        break;
      default:
        return this;
    }
  }
}

List<Restaurant> _filter(List<Restaurant> restaurants, String city) {
  Set<Restaurant> result = LinkedHashSet();
  result.clear();
  restaurants.forEach((value) {
    if (value.city == city) {
      result.add(value);
    }
  });

  return result.toList();
}

extension FailureMessageMapper on Failure {
  String mapFailureMessage() {
    if(this is ConnectionFailure) {
      return notInternetConnectionText;
    } else  {
      return systemBusyText;
    }
  }
}

extension RestaurantDetailToRestaurantMapper on RestaurantDetailEntity {
  Restaurant mapToRestaurant(){
    return Restaurant(
     id: this.id,
     name: this.name,
     description: this.description,
     pictureId: this.pictureId,
     city: this.city,
     rating: this.rating,
    );
  }
}