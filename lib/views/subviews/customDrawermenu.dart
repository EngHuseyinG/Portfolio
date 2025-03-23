import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/myassets.dart';
import 'package:portfolio/constants/screenDesigns.dart';
import 'package:portfolio/constants/text/appbarText.dart';
import 'package:portfolio/constants/widgetDesigns.dart';
import 'package:portfolio/viewmodels/autoScroll.dart';
import 'package:portfolio/viewmodels/googleTranslateService.dart';
import 'package:provider/provider.dart';

class Customdrawermenu extends StatelessWidget {

  final Mycolors _mycolors = Mycolors();
  final Myassets _myassets = Myassets();
  final Widgetdesigns _widgetdesigns = Widgetdesigns(kToolbarHeight);
  final Appbartext _appbartext = Appbartext();
   late bool _translateEN;

   Customdrawermenu(this._translateEN);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: _mycolors.myPaletteWhiteColor,
      width: context.dynamicWidth(0.75),
      child: Consumer2<Autoscroll, GoogleTranslateService>(builder: (context, _autoscroll,_translate,child) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           DrawerHeader(context, _translate),

           NavigationButtons(context, _autoscroll),
      ],
      );
      })
    );
  }

  Expanded NavigationButtons(BuildContext context, Autoscroll _autoscroll) {
    return Expanded(
           child: ListView(
             children: List.generate(6, (index) {
               return ListTile(
                 onTap: () {
                   Scaffold.of(context).closeDrawer();
                   WidgetsBinding.instance.addPostFrameCallback((_) {
                     _autoscroll.GotoIndex(index);
                   });
                 },
                 title: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   spacing: context.dynamicWidth(0.025),
                   children: [
                     SizedBox(width: context.dynamicWidth(0.025),),
                     _widgetdesigns.navigationIcons[index],
                     Text(_translateEN == true ? '${_appbartext.NavigationTooltipsEN[index]}' : '${_appbartext.NavigationTooltipsTR[index]}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: _mycolors.myPaletteRedColor),),
                   ],
                 ),
               );
             }),
           ),
         );
  }

  Container DrawerHeader(BuildContext context, GoogleTranslateService _translate) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeigth(0.35),
      decoration: _widgetdesigns.containerDecorationforPC,
      child: Padding(
        padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.025),0,0,0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing:context.dynamicHeigth(0.001),
          children: [
            SizedBox(height: context.dynamicHeigth(0.001),),

            Expanded(
              flex: 10,
              child: CircleAvatar(
                radius: context.dynamicWidth(0.20),
                backgroundImage: AssetImage(_myassets.profilePhotoAsset),
              ),
            ),
            Expanded(
                flex: 1,
                child:
                Text('${_translate.ResultofTexts['page1jobname']}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
            ),
            SizedBox(height: context.dynamicHeigth(0.025),),
          ],
        ),
      ),
    );
  }
}
