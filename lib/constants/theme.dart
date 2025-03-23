import 'package:flutter/material.dart';

class CustomTheme  {


  final ThemeData theme1 = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: false,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 5,
      shadowColor: Colors.black,
    )
  );

}
