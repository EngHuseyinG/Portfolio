import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/screenDesigns.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/viewmodels/databaseService.dart';
import 'package:portfolio/viewmodels/googleTranslateService.dart';
import 'package:portfolio/viewmodels/urlServices.dart';
import 'package:portfolio/viewmodels/autoScroll.dart';
import 'package:portfolio/viewmodels/mouseRegions.dart';
import 'package:portfolio/views/mainpage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Autoscroll(),),
        ChangeNotifierProvider(create: (context) => MouseRegions(),),
        ChangeNotifierProvider(create: (context) => Urlservices(),),
        ChangeNotifierProvider(create: (context) => GoogleTranslateService(),),
        ChangeNotifierProvider(create: (context) => DatabaseService(),),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   final _customTheme1 = CustomTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: _customTheme1.theme1,
      initialRoute: '/TR',
      scrollBehavior:  context.dynamicWidth(1) > 750 ?
      ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        PointerDeviceKind.trackpad,
      },
    ) :
      ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
        },
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/TR' :
            return CupertinoPageRoute(
                builder: (_) => Mainpagetr(false), settings: settings
            );
          case '/EN' :
            return CupertinoPageRoute(
                builder: (_) => Mainpagetr(true), settings: settings
            );
        }
        return null;
      },
    );
  }
}