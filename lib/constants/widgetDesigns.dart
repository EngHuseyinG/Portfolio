import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';



class Widgetdesigns extends Mycolors {

late double _kToolbarHeight;

Widgetdesigns(this._kToolbarHeight);

  final  BoxDecoration containerDecorationforPC = BoxDecoration(
    image:  DecorationImage(
        image: AssetImage('assets/images/pcbackground.jpg'),
        filterQuality: FilterQuality.low,
        fit: BoxFit.fill,
    ),
  );

  final  elevatedbuttonStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.white,
      elevation: 5,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
  ),);

  final List<Icon> navigationIcons = [
    Icon(Icons.home_outlined, color: Mycolors().myPaletteRedColor, size: kToolbarHeight * 0.5,),
    Icon(Icons.smartphone_outlined, color: Mycolors().myPaletteRedColor, size: kToolbarHeight * 0.5,),
    Icon(Icons.language_outlined, color: Mycolors().myPaletteRedColor, size: kToolbarHeight * 0.5,),
    Icon(Icons.offline_bolt_outlined, color: Mycolors().myPaletteRedColor, size: kToolbarHeight * 0.5,),
    Icon(Icons.star_border, color: Mycolors().myPaletteRedColor, size: kToolbarHeight * 0.5,),
    Icon(Icons.call_rounded, color: Mycolors().myPaletteRedColor, size: kToolbarHeight * 0.5,),
  ];

  // final TextStyle? _test = Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white);


}