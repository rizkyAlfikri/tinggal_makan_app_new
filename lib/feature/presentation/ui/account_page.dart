import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/feature/presentation/ui/setting_page.dart';
import 'package:tinggal_makan_app/feature/presentation/widget/custom_dialog.dart';

class AccountPage extends StatelessWidget {
  final List<String> _settingTitles = [
    profileText,
    paymentMethodText,
    orderHistoryText,
    deliveryAddressText,
    settingsText,
    aboutUsText,
    supportCenterText
  ];

  void _navigateToFeatureSetting(BuildContext context, String settingName){
    if(settingName == settingsText) {
      Navigator.pushNamed(context, SettingPage.routeName);
    } else {
      customDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(266, 266, 266, 266),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 48,),
            alignment: Alignment.topLeft,
            child: ListTile(
              leading: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 56,
                  ),
                ),
              ),
              title: Text(
                usernameText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text(
                emailText,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
                margin: const EdgeInsets.all(0),
                color: Colors.white,
                child: Wrap(
                    children: _settingTitles
                        .map((title) => Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                              child: ListTile(
                                title: Text(
                                  title,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                trailing: Icon(
                                  Platform.isAndroid
                                      ? Icons.arrow_forward_ios
                                      : CupertinoIcons.right_chevron,
                                  color: Colors.black87,
                                  size: 18,
                                ),
                                onTap: () {
                                  _navigateToFeatureSetting(context, title);
                                },
                              ),
                            ))
                        .toList())),
          )
        ],
      ),
    );
  }
}
