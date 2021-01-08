import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';

Widget customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(commingSoonText),
          content: Text(thisFeatureCoomingSoonText),
          actions: [
            CupertinoDialogAction(
              child: Text(okText),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(commingSoonText),
          content: Text(thisFeatureCoomingSoonText),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(okText),
            ),
          ],
        );
      },
    );
  }
}
