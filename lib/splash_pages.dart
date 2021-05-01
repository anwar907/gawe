import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mogawe/pages/pages.dart';
import 'package:mogawe/services/api_controller.dart';

class SplashLoadingScreen extends StatefulWidget {
  static const routeName = '/splash-loading-screen';
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashLoadingScreen> {
  final ApiServiceController user = Get.put(ApiServiceController());
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    var token = await user.getToken().then((value) => value);
    print('ADA TOKEN GAK $token');
    return new Timer(duration, () => route(token));
  }

  route(String token) {
    // Check whether logged in or not
    if (token != null) {
      // Redirect into Home
      print("ADA TOKEN");
      Get.off(() => ProfilePages());
    } else {
      print("TIDAK ADA TOKEN");
      Get.off(() => LoginPage());
    }
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
          ],
        ),
      ),
    );
  }
}
