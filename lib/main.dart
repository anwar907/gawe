import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mogawe/splash_pages.dart';

import 'pages/pages.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // same as home arguments
        '/': (ctx) => SplashLoadingScreen(),
        SplashLoadingScreen.routeName: (ctx) => SplashLoadingScreen(),
        LoginPage.routeName: (ctx) => LoginPage(),
        ProfilePages.routeName: (ctx) => ProfilePages(),
      },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          settings: ModalRoute.of(context).settings,
          builder: (ctx) => SplashLoadingScreen(),
        );
      },
    );
  }
}
