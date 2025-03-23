import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/screenDesigns.dart';
import 'package:portfolio/constants/text/appbarText.dart';
import 'package:portfolio/constants/widgetDesigns.dart';
import 'package:portfolio/viewmodels/autoScroll.dart';
import 'package:portfolio/viewmodels/googleTranslateService.dart';
import 'package:portfolio/viewmodels/urlServices.dart';
import 'package:provider/provider.dart';


class Customappbar extends StatelessWidget implements PreferredSizeWidget {

  final Mycolors _mycolors = Mycolors();

  final Appbartext _appbartext = Appbartext();

  final Widgetdesigns _widgetdesigns = Widgetdesigns(kToolbarHeight);

  final String _triconasset = 'assets/icons/tricon.png';

  final String _eniconasset = 'assets/icons/enicon.png';

  late bool _translateEN;


  Customappbar(this._translateEN);

  @override
  Widget build(BuildContext context) {
    final _autoscroll = Provider.of<Autoscroll>(context, listen: false);
    final _urlservices = Provider.of<Urlservices>(context, listen: false);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            context.dynamicWidth(1) < 750 ?
            DrawerMenuButton(context) :
            NavigationButtons(_autoscroll),
            //Text('${Uri.base.origin}', style: TextStyle(color: Colors.black),),
            TranslatorSwitchButton(context, _autoscroll, _urlservices),
        ],
      ),
    );
  }

  Row TranslatorSwitchButton(BuildContext context, Autoscroll _autoscroll, Urlservices _urlservices) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Image.asset(_triconasset, height: kToolbarHeight * 0.5,),
                  Switch(
                    activeColor: _mycolors.myPaletteBlueColor,
                    inactiveTrackColor: _mycolors.myPaletteRedColor,
                    value: _translateEN,
                    onChanged: (newValue) {
                        Provider.of<GoogleTranslateService>(context, listen: false).TranslatorStarted();
                        if(newValue == false) {
                          _autoscroll.UpdateProfilePhotoScale(0.0);
                          _urlservices.openNewUrl('${Uri.base.origin}', '_self');
                        }
                        else {
                          _autoscroll.UpdateProfilePhotoScale(0.0);
                          _urlservices.openNewUrl('${Uri.base.origin}/#/EN', '_self');
                        }
                  },
                  ),
                  Image.asset(_eniconasset, height: kToolbarHeight * 0.5,),
                ],
              ),
            ],
          );
  }

  Row NavigationButtons(Autoscroll _autoscroll) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: kToolbarHeight * 0.5,
            children:
            List.generate(6, (index) {
              return IconButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _autoscroll.GotoIndex(index);
                  });
                },
                tooltip: _translateEN == true ? _appbartext.NavigationTooltipsEN[index] : _appbartext.NavigationTooltipsTR[0],
                icon: _widgetdesigns.navigationIcons[index],
              );
            }),
          );
  }

  IconButton DrawerMenuButton(BuildContext context) {
    return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: _mycolors.myPaletteRedColor,),);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
