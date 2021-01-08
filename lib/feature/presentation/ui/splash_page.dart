import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinggal_makan_app/core/common/strings.dart';
import 'package:tinggal_makan_app/core/common/style.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/splashRoute";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation curve;
  Animation<double> alpha;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    curve = CurvedAnimation(parent: _controller, curve: Curves.easeInToLinear);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _moveToHomePage(BuildContext context) {
    return Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    _moveToHomePage(context);
    return Container(
        color: secondaryColor,
        child: Stack(
          children: [
            FadeTransition(
              opacity: alpha,
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          Icons.restaurant_menu,
                          size: 72,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        appTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
