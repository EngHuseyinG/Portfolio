import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/myassets.dart';
import 'package:portfolio/constants/screenDesigns.dart';
import 'package:portfolio/constants/widgetDesigns.dart';
import 'package:portfolio/viewmodels/databaseService.dart';
import 'package:portfolio/viewmodels/googleTranslateService.dart';
import 'package:portfolio/viewmodels/urlServices.dart';
import 'package:portfolio/constants/text/pagesTextTR.dart';
import 'package:portfolio/viewmodels/autoScroll.dart';
import 'package:portfolio/viewmodels/mouseRegions.dart';
import 'package:portfolio/views/subviews/customAppBar.dart';
import 'package:portfolio/views/subviews/customDrawermenu.dart';
import 'package:provider/provider.dart';

class Mainpagetr extends StatefulWidget {


  late bool _translateEN;

  Mainpagetr(this._translateEN);

  @override
  State<Mainpagetr> createState() => _MainpagetrState(_translateEN);
}

class _MainpagetrState extends State<Mainpagetr> {

  // Sayfa için özel tanımlananlar
  final Widgetdesigns _widgetdesigns = Widgetdesigns(kToolbarHeight);
  final Pagestext _pagestext = Pagestext();
  final Mycolors _mycolors = Mycolors();
  final Myassets _myassets = Myassets();


  final ScrollController _scrollController = ScrollController();
  bool _updatedMobileAppScales = false;
  bool _updatedWebAppScales = false;
  bool _updateModuleScales = false;
  bool _updateSkillsScales = false;
  late bool _translateEN;
  ScrollController _mobileAppsControllerforMobileGridView = ScrollController();
  ScrollController _mobileAppsControllerforMobileScrollView = ScrollController();
  ScrollController _WebAppsControllerforMobileScrollView = ScrollController();
  ScrollController _SkillsControllerforMobileGridView = ScrollController();


  _MainpagetrState(this._translateEN);


  @override
  void initState() {


    Future.delayed(Duration(seconds: 1), () {
      _runTranslator();
    });

   if(_translateEN == false) {
     Future.delayed(Duration(seconds: 2), () {
       _sendInformationstoDatabase();
     });
   }



    _scrollController.addListener(() {
      if(_scrollController.position.pixels > context.dynamicHeigth(0.55) && _updatedMobileAppScales == false) {
        _UpdateMobileappCardsScale();
          _sendInformationstoDatabase2();

      }
      if(_scrollController.position.pixels > context.dynamicHeigth(1.55) && _updatedWebAppScales == false) {
        _UpdateWebappCardsScale();

      }
      if(_scrollController.position.pixels > context.dynamicHeigth(2.55) && _updateModuleScales == false) {
        _UpdateModuleCardScale();
      }
      if(_scrollController.position.pixels > context.dynamicHeigth(3.75) && _updateSkillsScales == false) {
        _UpdateSkillsCardScale();
      }
    });


    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  // Scroll'u belirli bir Container'a kaydıran fonksiyon
  Future _scrollToContainer(int key, BuildContext context) async {
    var position = MediaQuery.of(context).size.height * key;
    // Scroll the container into view using ensureVisible
    await _scrollController.animateTo(position,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

    Provider.of<Autoscroll>(context, listen: false).WenttoIndex();
  }

  void _runTranslator()  {
    Provider.of<GoogleTranslateService>(context, listen: false).translateText(_translateEN);
    Future.delayed(Duration(milliseconds: 1250), () {
      _UpdateProfilePhotoScale();
    });
  }

  void _UpdateMobileappCardsScale() async {
    Provider.of<Autoscroll>(context, listen: false).GrowupMobileAppCard(1.0);
    _updatedMobileAppScales = true;
    _mobileAppsControllerforMobileGridView.animateTo(_mobileAppsControllerforMobileGridView.position.maxScrollExtent, duration: Duration(milliseconds: 1500), curve: Curves.linear);
    _mobileAppsControllerforMobileScrollView.animateTo(_mobileAppsControllerforMobileScrollView.position.maxScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    Future.delayed(Duration(seconds: 2), () {
      _mobileAppsControllerforMobileGridView.animateTo(_mobileAppsControllerforMobileGridView.position.minScrollExtent, duration: Duration(milliseconds: 1500), curve: Curves.linear);
      _mobileAppsControllerforMobileScrollView.animateTo(_mobileAppsControllerforMobileScrollView.position.minScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    });
  }

  void _UpdateWebappCardsScale() async {
    Provider.of<Autoscroll>(context, listen: false).GrowupWebAppCard(1.0);
    _updatedWebAppScales = true;
    _SkillsControllerforMobileGridView.animateTo(_SkillsControllerforMobileGridView.position.maxScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    Future.delayed(Duration(seconds: 2), () {
      _SkillsControllerforMobileGridView.animateTo(_SkillsControllerforMobileGridView.position.minScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    });
  }

  void _UpdateModuleCardScale() async {
    Provider.of<Autoscroll>(context, listen: false).GrowupModuleCard(1.0);
    _updateModuleScales = true;
  }

  void _UpdateProfilePhotoScale() async {
  Provider.of<Autoscroll>(context, listen: false).UpdateProfilePhotoScale(context.dynamicHeigth(0.3));
}

  void _UpdateSkillsCardScale() async {
    _updateSkillsScales = true;
    _SkillsControllerforMobileGridView.animateTo(_SkillsControllerforMobileGridView.position.maxScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    Future.delayed(Duration(seconds: 2), () {
      _SkillsControllerforMobileGridView.animateTo(_SkillsControllerforMobileGridView.position.minScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    });
  }

  void _ShowSnackbar(String message, int duration) async {
    var snackBar = SnackBar(
      duration: Duration(milliseconds: duration),
      backgroundColor: _mycolors.myPaletteRedColor,
      content: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
    await ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _sendInformationstoDatabase() async {
    Provider.of<DatabaseService>(context, listen: false).GetUserInformations();
  }

  void _sendInformationstoDatabase2() async {
    if(_translateEN == false) {
      Provider.of<DatabaseService>(context, listen: false).GetUserInformations2();
    }
  }

  Future<void> _OpenNewURL(String _url, String _mode) async {
    await Provider.of<Urlservices>(context, listen: false).openNewUrl(_url, _mode);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(_translateEN),
      drawer: context.dynamicWidth(1) < 750 ?
      Customdrawermenu(_translateEN) : null,
      body:
      Consumer4<MouseRegions, Autoscroll, GoogleTranslateService, Urlservices>(
              builder: (context, _mouseregions , _autoscroll, _translate, _urlservice, child) {
                // If get a command from navigation button, scroll to page
                if (_autoscroll.scrolled == true) {
                  _scrollToContainer(_autoscroll.index, context);
                }


                // The main widget is container has blue wallpaper and it continues with sections
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                  _widgetdesigns.containerDecorationforPC,
                  child: _translate.loadingTranslator == true ?
                  Center(child: CircularProgressIndicator(color: Colors.white,),)  :
                  context.dynamicWidth(1) < 750 ?
                  MainContainerforMobileSections(context, _autoscroll, _translate, _mouseregions, _urlservice) :
                  MainContainerforPCSections(context, _autoscroll, _translate, _mouseregions)
                );
              },
            ),
    );
  }


  //Wide Screens

  Widget MainContainerforPCSections(BuildContext context, Autoscroll _autoscroll, GoogleTranslateService _translate, MouseRegions _mouseregions) {
    return ListView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      children: [
        SizedBox(
          height: context.dynamicHeigth(1),
          width: context.dynamicWidth(1),
          child: Container1WidgetsforPC(context, _autoscroll, _translate),
        ),  // Genel Profil ve Kişi Section
        SizedBox(
          height: context.dynamicHeigth(1),
          width: context.dynamicWidth(1),
          child:  Container2WidgetsforPC(context, _mouseregions, _autoscroll, _translate),
        ),  // Mobil Uygulamaların gösterildiği Section
        SizedBox(
          height: context.dynamicHeigth(1),
          width: context.dynamicWidth(1),
          child: Container3WidgetsforPC(context, _mouseregions, _autoscroll, _translate),
        ),  // Web uygulamaların Gösterildiği Section
        SizedBox(
          height: context.dynamicHeigth(1),
          width: context.dynamicWidth(1),
          child: Container4WidgetsforPC(context, _mouseregions, _autoscroll, _translate),
        ),  // Ürünlerin/Modülün Gösterildiği Section
        SizedBox(
          height: context.dynamicHeigth(1),
          width: context.dynamicWidth(1),
          child: Container5WidgetsforPC(context, _mouseregions, _autoscroll, _translate),
        ), // Yeteneklerin Gösterildiği Section
        SizedBox(
          height: context.dynamicHeigth(1) - kToolbarHeight,
          width: context.dynamicWidth(1),
          child: Container6WidgetsforPC(context, _autoscroll, _translate),
        ),  // İletişim ve Bonus Section
      ],
    );
  }

  //Sayfada ilk section: Profil resmi ve giriş
  Widget Container1WidgetsforPC(BuildContext context, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.dynamicHeigth(1) < 500
            ? SizedBox()
            : Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: AnimatedContainer(
            height: _autoscroll.profilePhotoSize,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(_myassets.profilePhotoAsset),
              radius: _autoscroll.profilePhotoSize * 0.5,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            _pagestext.page1Name,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(context.dynamicWidth(0.025),),
          child: Column(
            spacing: context.dynamicHeigth(0.025),
            children: [
              FittedBox(
                child: Text(
                  _translate.ResultofTexts['page1jobname'],
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
              Text(
                _translate.ResultofTexts['page1description'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
                softWrap: true,
              ),
            ],
          ),
        ),
        context.dynamicHeigth(1) < 500
            ? SizedBox()
            : ElevatedButton.icon(
                onPressed: () {
                  _scrollToContainer(1, context);
                },
                iconAlignment: IconAlignment.end,
                label: Text(
                  _translate.ResultofTexts['page1morebutton'],
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: kToolbarHeight * 0.75,
                ),
                style: _widgetdesigns.elevatedbuttonStyle,
              ),
        SizedBox(
          height: kToolbarHeight,
        ),
      ],
    );
  }

  // Sayfada ikinci section: Mobil Uygulamalar
  Widget Container2WidgetsforPC(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.025),),
        Text(
          _translate.ResultofTexts['page2Title'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: context.dynamicWidth(1) < 1280 ? 2 : 3,
            mainAxisSpacing: context.dynamicHeigth(0.025),
            crossAxisSpacing: context.dynamicWidth(0.025),
            childAspectRatio: 1.75,
            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0),),
            children: List.generate(4, (index) {
              return MouseRegion(
                onHover: (_) {
                  Provider.of<MouseRegions>(context, listen: false).MobileAppHovered(index);
                },
                onExit: (_) {
                  Provider.of<MouseRegions>(context, listen: false).MobileAppHovered(99);
                },
                child: AnimatedScale(
                  scale: _mouseregions.mobileAppMouseregion == index ?
                  1.1 : _autoscroll.mobileappCardScale,
                  duration: Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: () {

                      switch(index) {
                        case 0:
                          Provider.of<DatabaseService>(context, listen: false).TbookClicked();
                        case 1:
                          Provider.of<DatabaseService>(context, listen: false).MbookClicked();
                        case 2:
                          Provider.of<DatabaseService>(context, listen: false).KbookClicked();
                        case 3:
                          Provider.of<DatabaseService>(context, listen: false).NbookClicked();
                      }

                      Provider.of<Urlservices>(context, listen: false).openNewUrl(_myassets.mobileAppYoutubeLinks[index], 'new tab');
                    },
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.white,
                      elevation: _mouseregions.mobileAppMouseregion == index ? 25 : 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 3,
                            child: FittedBox(
                              child: Text(
                                _myassets.mobileAppNames[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: Image.asset(
                              _myassets.mobileAppAssets[index],
                              filterQuality: FilterQuality.low,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              _myassets.mobileAppLanguages[index],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: context.dynamicWidth(0.01),
                children: List.generate(_myassets.mobileAppStickers.length, (index) {
                  return MouseRegion(
                    onHover: (_) {
                      Provider.of<MouseRegions>(context, listen: false).MobileStickerHovered(index);
                    },
                    onExit: (_) {
                      Provider.of<MouseRegions>(context, listen: false).MobileStickerHovered(99);
                    },
                    child: AnimatedScale(
                      scale: _mouseregions.mobileStickerMouseRegion == index ? 1.25 : 1,
                      duration: Duration(milliseconds: 300),
                      child: Card(
                        elevation: _mouseregions.mobileStickerMouseRegion == index ? 25 : 5,
                        shadowColor: Colors.white,
                        child: Padding(
                          child: Text(_myassets.mobileAppStickers[index], style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),),
                          padding: EdgeInsets.all(10),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  );
                },
                ),
              ),
            ),
        SizedBox(height: context.dynamicHeigth(0.085),),
      ],
    );
  }

  // Sayfada üçüncü section: Web Uygulamalar
  Widget Container3WidgetsforPC(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.025),),
        Text(
          _translate.ResultofTexts['page3Title'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: context.dynamicHeigth(0.2),
            crossAxisSpacing: context.dynamicWidth(0.1),
            childAspectRatio: 1.25,
            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.0),),
            children: List.generate(2, (index) {
              return MouseRegion(
                onHover: (_) {
                  Provider.of<MouseRegions>(context, listen: false).WebAppHovered(index);
                },
                onExit: (_) {
                  Provider.of<MouseRegions>(context, listen: false).WebAppHovered(99);
                },
                child: AnimatedScale(
                  scale: _mouseregions.webAppMouseregion == index ?
                  1.1 : _autoscroll.webappCardScale,
                  duration: Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: () {
                      switch(index) {
                        case 0:
                          Provider.of<DatabaseService>(context, listen: false).TeleportalClicked();
                        case 1:
                          Provider.of<DatabaseService>(context, listen: false).PortfolioClicked();
                      }
                      Provider.of<Urlservices>(context, listen: false).openNewUrl(_myassets.webAppYoutubeLinks[index], 'new tab');
                    },
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.white,
                      elevation: _mouseregions.webAppMouseregion == index ? 25 : 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 3,
                            child: FittedBox(
                              child: Text(
                                _myassets.webAppNames[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Image.asset(
                              _myassets.webAppsAssets[index],
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              _myassets.webAppLanguages[index],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: context.dynamicWidth(0.01),
            children: List.generate(_myassets.webAppStickers.length, (index) {
              return MouseRegion(
                onHover: (_) {
                  Provider.of<MouseRegions>(context, listen: false).WebStickerHovered(index);
                },
                onExit: (_) {
                  Provider.of<MouseRegions>(context, listen: false).WebStickerHovered(99);
                },
                child: AnimatedScale(
                  scale: _mouseregions.webStickerMouseRegion == index ? 1.25 : 1,
                  duration: Duration(milliseconds: 300),
                  child: Card(
                    elevation: _mouseregions.webStickerMouseRegion == index ? 25 : 5,
                    shadowColor: Colors.white,
                    child: Padding(
                      child: Text(_myassets.webAppStickers[index], style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),),
                      padding: EdgeInsets.all(10),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              );
            },
            ),
          ),
        ),
        SizedBox(height: context.dynamicHeigth(0.085),),

      ],
    );
  }

  // Sayfada dördüncü section: Ürünler(Teleportal Modülü)
  Widget Container4WidgetsforPC(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.025),),
        Text(
          _translate.ResultofTexts['page4Title'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        Expanded(
          child: AnimatedScale(
            scale: _autoscroll.moduleCardScale,
            duration: Duration(milliseconds: 300),
            child: MouseRegion(
              onHover: (_) {
                Provider.of<MouseRegions>(context, listen: false).ModuleCardHovered(true);
              },
              onExit: (_) {
                Provider.of<MouseRegions>(context, listen: false).ModuleCardHovered(false);
              },
              child: Card(
                margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.1),),
                color: Colors.white,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: _mouseregions.moduleCardHovered == true ? 25 : 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.all(context.dynamicWidth(0.025),),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 40,
                              child: Image.asset(_myassets.moduleAssets[_autoscroll.showedModuleAsset],),
                            ),
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                _myassets.moduleIconAsset,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ), // Modül Foto
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: context.dynamicHeigth(0.05),
                        children: List.generate(3, (_listindex) {
                          return MouseRegion(
                            onHover: (_) {
                              _mouseregions.ModulePictureHovered(_listindex);
                            },
                            onExit: (_) {
                              _mouseregions.ModulePictureHovered(99);
                            },
                            child: AnimatedScale(
                              scale: _mouseregions.modulePictureregion == _listindex ? 1.5 : 1,
                              duration: Duration(milliseconds: 300),
                              child: GestureDetector(
                                onTap: () {
                                  _autoscroll.UpdateModuleAsset(_listindex);
                                },
                                child: Container(
                                  height: context.dynamicHeigth(0.1),
                                  width: context.dynamicHeigth(0.1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: _mycolors.myPaletteBlueColor),
                                  ),
                                  child: Image.asset(_myassets.moduleAssets[_listindex],),
                                ),
                              ),
                            ),
                          );
                        },
                        ),
                      ),
                    ), // Module Photo Select
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: context.dynamicHeigth(0.05),
                          ),
                          Text('TeleportWiFi', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black) ,),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(context.dynamicHeigth(0.05),),
                                child:
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _translate.ResultofTexts['page4ModuleDescription1'],
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: _translate.ResultofTexts['page4ModuleDescription2'],
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: _translate.ResultofTexts['page4ModuleDescription3'],
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: _translate.ResultofTexts['page4ModuleDescription4'],
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: _translate.ResultofTexts['page4ModuleDescription5'],
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ), //Module Description Text
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  // Sayfada beşinci section: Hakkında ve Yetenekler
  Widget Container5WidgetsforPC(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.015),),
        Text(
          _translate.ResultofTexts['page5Title1'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ), // HAKKIMDA
       Expanded(
           flex: 7,
           child: SizedBox.expand(
             child: Card(
               margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
               color: Colors.white,
               shadowColor: Colors.white,
               elevation: 5,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),
               ),
               child: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child: Padding(
                   padding: EdgeInsets.all(context.dynamicHeigth(0.05),),
                   child:
                   Text.rich(
                     TextSpan(
                       children: [
                         TextSpan(
                           text: _translate.ResultofTexts['page5AboutMe1'],
                           style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                         ),
                         TextSpan(
                           text: _translate.ResultofTexts['page5AboutMe2'],
                           style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                         ),
                         TextSpan(
                           text: _translate.ResultofTexts['page5AboutMe3'],
                           style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                         ),
                       ],
                     ),
                     textAlign: TextAlign.justify,
                   ),
                 ),
               ),
             ),
           ),
       ),
        Text(
          _translate.ResultofTexts['page5Title2'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ), // TECRÜBELER BAŞLIĞI
        Expanded(
          flex: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: context.dynamicHeigth(0.025),),
                        Text(_pagestext.page5SkillsTitle1, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                        Expanded(
                          child: GridView.count(
                            mainAxisSpacing: context.dynamicHeigth(0.01),
                            crossAxisSpacing: context.dynamicWidth(0.01),
                            childAspectRatio: 1,
                            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.001), context.dynamicWidth(0.05), context.dynamicHeigth(0.001),),
                            crossAxisCount: 2,
                            children: List.generate(_myassets.skillsAssets.length, (index) {
                                  return Tooltip(
                                    message: _myassets.skillsToolTips[index],
                                    child: SizedBox(
                                      width: 25,
                                      child: Image.asset(_myassets.skillsAssets[index], fit: BoxFit.fitWidth,),
                                    ),
                                  );
                            } ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: context.dynamicHeigth(0.025),),
                        Text(_pagestext.page5SkillsTitle2, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                        Expanded(
                          child: GridView.count(
                            mainAxisSpacing: context.dynamicHeigth(0.01),
                            crossAxisSpacing: context.dynamicWidth(0.01),
                            childAspectRatio: 1,
                            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.001), context.dynamicWidth(0.05), context.dynamicHeigth(0.001),),
                            crossAxisCount: 2,
                            children: List.generate(_myassets.backendAssets.length, (index) {
                              return Tooltip(
                                message: _myassets.backendToolTips[index],
                                child: SizedBox(
                                  width: 25,
                                  child: Image.asset(_myassets.backendAssets[index], fit: BoxFit.fitWidth,),
                                ),
                              );
                            } ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: context.dynamicHeigth(0.025),),
                        Text(_pagestext.page5SkillsTitle3, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                        Expanded(
                          child: GridView.count(
                            mainAxisSpacing: context.dynamicHeigth(0.01),
                            crossAxisSpacing: context.dynamicWidth(0.01),
                            childAspectRatio: 1,
                            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.001), context.dynamicWidth(0.05), context.dynamicHeigth(0.001),),
                            crossAxisCount: 2,
                            children: List.generate(_myassets.extraAssets.length, (index) {
                              return Tooltip(
                                message: _myassets.extraTooltips[index],
                                child: SizedBox(
                                  width: 25,
                                  child: Image.asset(_myassets.extraAssets[index], fit: BoxFit.fitWidth,),
                                ),
                              );
                            } ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
       Expanded(
         flex: 2,
         child: SizedBox(),
       ),
      ],
    );
  }

  // Sayfada altıncı section: Bonus ve İletişim
  Widget Container6WidgetsforPC(BuildContext context, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      children: [
        Divider(thickness: 1, color: Colors.white,),
        SizedBox(height: context.dynamicHeigth(0.015),),
        Text('Bonus', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),),
        Expanded(
          flex: 15,
          child: Padding(
            padding:  EdgeInsets.all(context.dynamicWidth(0.025),),
            child: Column(
              spacing: context.dynamicHeigth(0.025),
                  children: [
                    Expanded(
                        child: Image.asset(_myassets.bonusAssets[_autoscroll.bonusAssetSlide], fit: BoxFit.contain,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: context.dynamicWidth(0.025),
                      children: [
                        IconButton(onPressed: () {
                          Provider.of<Autoscroll>(context, listen: false).BonusSlideDecrement();

                        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,),),
                        IconButton(
                          onPressed: () {
                          Provider.of<Autoscroll>(context, listen: false).BonusSlideIncrement();

                        }, icon: Icon(Icons.arrow_forward_ios, color: Colors.white,),),
                      ],
                    ),
                  ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
            width: context.dynamicWidth(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: context.dynamicWidth(0.01),
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<Urlservices>(context, listen: false).openNewUrl(_pagestext.page6githubURL, 'new tab');
                  },
                  iconSize: kToolbarHeight,
                  icon: Image.asset(_myassets.communicationIconAssets[0],//Github IconButton
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<Urlservices>(context, listen: false).openNewUrl(_pagestext.page6linkedinURL, 'new tab');
                  },
                  iconSize: kToolbarHeight,
                  icon: Image.asset(_myassets.communicationIconAssets[1], //Linkedin Icon Button
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  tooltip: 'enghuseyingurel@gmail.com',
                  iconSize: kToolbarHeight,
                  icon: Image.asset(_myassets.communicationIconAssets[2], //Email Icon Button
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(child: Text(_translate.ResultofTexts['page6allrights'], style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),),
        ),
      ],
    );
  }


  // Mobile Screens


  Widget MainContainerforMobileSections(BuildContext context, Autoscroll _autoscroll, GoogleTranslateService _translate, MouseRegions _mouseregions, Urlservices _urlservice) {
    return RefreshIndicator(
      onRefresh: () async {
      //  _OpenNewURL('${Uri.base.authority}/#${Uri.base.fragment}', '_self');

        _OpenNewURL('/#${Uri.base.fragment}', '_self');
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        children: [
          SizedBox(
            height: context.dynamicHeigth(1),
            width: context.dynamicWidth(1),
            child: Container1WidgetsforMobile(context, _autoscroll, _translate) ,
          ),  // Genel Profil ve Kişi Section
          SizedBox(
            height: context.dynamicHeigth(1),
            width: context.dynamicWidth(1),
            child: Container2WidgetsforMobile(context, _mouseregions, _autoscroll, _translate)
          ),  // Mobil Uygulamaların gösterildiği Section
          SizedBox(
            height: context.dynamicHeigth(1),
            width: context.dynamicWidth(1),
            child: Container3WidgetsforMobile(context, _mouseregions, _autoscroll, _translate),
          ),  // Web uygulamaların Gösterildiği Section
          SizedBox(
            height: context.dynamicHeigth(1),
            width: context.dynamicWidth(1),
            child: Container4WidgetsforMobile(context, _mouseregions, _autoscroll, _translate),
          ),  // Ürünlerin/Modülün Gösterildiği Section
          SizedBox(
            height: context.dynamicHeigth(1),
            width: context.dynamicWidth(1),
            child: Container5WidgetsforMobile(context, _mouseregions, _autoscroll, _translate),
          ), // Yeteneklerin Gösterildiği Section
          SizedBox(
            height: context.dynamicHeigth(1) - kToolbarHeight,
            width: context.dynamicWidth(1),
            child: Container6WidgetsforMobile(context, _autoscroll, _translate),
          ),  // İletişim ve Bonus Section
        ],
      ),
    );
  }

  //Mobil için Sayfada ilk section: Profil resmi ve r
  Widget Container1WidgetsforMobile(BuildContext context, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.dynamicHeigth(1) < 500
            ? SizedBox()
            : Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: AnimatedContainer(
            height: _autoscroll.profilePhotoSize,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(_myassets.profilePhotoAsset),
              radius: _autoscroll.profilePhotoSize * 0.5,
            ),
          ),
        ),
        //Text('${Uri.base.authority}/#${Uri.base.fragment}', style: TextStyle(color: Colors.white),),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            _pagestext.page1Name,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(context.dynamicWidth(0.025),),
          child: Column(
            spacing: context.dynamicHeigth(0.025),
            children: [
              FittedBox(
                child: Text(
                  _translate.ResultofTexts['page1jobname'],
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
              Text(
                _translate.ResultofTexts['page1description'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
                softWrap: true,
              ),
            ],
          ),
        ),
        context.dynamicHeigth(1) < 500
            ? SizedBox()
            : ElevatedButton.icon(
          onPressed: () {
            _scrollToContainer(1, context);
          },
          iconAlignment: IconAlignment.end,
          label: Text(
            _translate.ResultofTexts['page1morebutton'],
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: kToolbarHeight * 0.75,
          ),
          style: _widgetdesigns.elevatedbuttonStyle,
        ),
        SizedBox(
          height: kToolbarHeight,
        ),
      ],
    );
  }

  //Mobil için sayfada ikinci section: Mobil Uygulamalar
  Widget Container2WidgetsforMobile(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.025),),
        Text(
          _translate.ResultofTexts['page2Title'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: context.dynamicHeigth(0.025),
            crossAxisSpacing: context.dynamicWidth(0.025),
            childAspectRatio: 0.75,
            scrollDirection: Axis.horizontal,
            controller: _mobileAppsControllerforMobileGridView,
            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0),),
            children: List.generate(4, (index) {
              return AnimatedScale(
                scale:_autoscroll.mobileappCardScale,
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    switch(index) {
                      case 0:
                        Provider.of<DatabaseService>(context, listen: false).TbookClicked();
                      case 1:
                        Provider.of<DatabaseService>(context, listen: false).MbookClicked();
                      case 2:
                        Provider.of<DatabaseService>(context, listen: false).KbookClicked();
                      case 3:
                        Provider.of<DatabaseService>(context, listen: false).NbookClicked();
                    }
                    Provider.of<Urlservices>(context, listen: false).openNewUrl(_myassets.mobileAppYoutubeLinks[index], 'new tab');
                  },
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: _mouseregions.mobileAppMouseregion == index ? 25 : 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 3,
                          child: FittedBox(
                            child: Text(
                              _myassets.mobileAppNames[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 30,
                          child: Image.asset(
                            _myassets.mobileAppAssets[index],
                            filterQuality: FilterQuality.low,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            _myassets.mobileAppLanguages[index],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _mobileAppsControllerforMobileScrollView,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: context.dynamicWidth(0.01),
            children: List.generate(_myassets.mobileAppStickers.length, (index) {
              return Card(
                elevation: _mouseregions.mobileStickerMouseRegion == index ? 25 : 5,
                shadowColor: Colors.white,
                child: Padding(
                  child: Text(_myassets.mobileAppStickers[index], style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),),
                  padding: EdgeInsets.all(10),
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                ),
              );
            },
            ),
          ),
        ),
        SizedBox(height: context.dynamicHeigth(0.085),),
      ],
    );
  }

  //Mobil Sayfada üçüncü section: Web Uygulamalar
  Widget Container3WidgetsforMobile(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.025),),
        Text(
          _translate.ResultofTexts['page3Title'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: context.dynamicHeigth(0.025),
            crossAxisSpacing: context.dynamicWidth(0.025),
            childAspectRatio: 0.7,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.025), context.dynamicHeigth(0.0),),
            children: List.generate(2, (index) {
              return AnimatedScale(
                scale: _autoscroll.webappCardScale,
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<DatabaseService>(context, listen: false).TeleportalClicked();
                    Provider.of<Urlservices>(context, listen: false).openNewUrl(_myassets.webAppYoutubeLinks[index], 'new tab');
                  },
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: _mouseregions.webAppMouseregion == index ? 25 : 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 3,
                          child: FittedBox(
                            child: Text(
                              _myassets.webAppNames[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 40,
                          child: Image.asset(
                            _myassets.webAppsAssets[index],
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            _myassets.webAppLanguages[index],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _WebAppsControllerforMobileScrollView,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: context.dynamicWidth(0.01),
            children: List.generate(_myassets.webAppStickers.length, (index) {
              return Card(
                elevation: _mouseregions.webStickerMouseRegion == index ? 25 : 5,
                shadowColor: Colors.white,
                child: Padding(
                  child: Text(_myassets.webAppStickers[index], style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),),
                  padding: EdgeInsets.all(10),
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                ),
              );
            },
            ),
          ),
        ),
        SizedBox(height: context.dynamicHeigth(0.085),),

      ],
    );
  }

  //Mobil sayfada dördüncü section: Ürünler(Teleportal Modülü)
  Widget Container4WidgetsforMobile(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.025),),
        Text(
          _translate.ResultofTexts['page4Title'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        Expanded(
          child: AnimatedScale(
            scale: _autoscroll.moduleCardScale,
            duration: Duration(milliseconds: 300),
            child: Card(
              margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.1),),
              color: Colors.white,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: _mouseregions.moduleCardHovered == true ? 25 : 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.all(context.dynamicWidth(0.025),),
                      child: Column(
                        children: [
                          Text('TeleportWiFi', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black) ,),
                          Expanded(
                            flex: 30,
                            child: Image.asset(_myassets.moduleAssets[_autoscroll.showedModuleAsset],),
                          ),
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              _myassets.moduleIconAsset,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ), // Modül Foto
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: context.dynamicHeigth(0.05),
                      children: List.generate(3, (_listindex) {
                        return GestureDetector(
                          onTap: () {
                            _autoscroll.UpdateModuleAsset(_listindex);
                          },
                          child: Container(
                            height: context.dynamicHeigth(0.1),
                            width: context.dynamicHeigth(0.1),
                            decoration: BoxDecoration(
                              border: Border.all(color: _mycolors.myPaletteBlueColor),
                            ),
                            child: Image.asset(_myassets.moduleAssets[_listindex],),
                          ),
                        );
                      },
                      ),
                    ),
                  ), // Module Photo Select
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.all(context.dynamicHeigth(0.025),),
                      child:
                      SingleChildScrollView(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: _translate.ResultofTexts['page4ModuleDescription1'],
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                              ),
                              TextSpan(
                                text: _translate.ResultofTexts['page4ModuleDescription2'],
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                              ),
                              TextSpan(
                                text: _translate.ResultofTexts['page4ModuleDescription3'],
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                              ),
                              TextSpan(
                                text: _translate.ResultofTexts['page4ModuleDescription4'],
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                              ),
                              TextSpan(
                                text: _translate.ResultofTexts['page4ModuleDescription5'],
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ), //Module Description Text
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Mobile sayfada beşinci section: Hakkında ve Yetenekler
  Widget Container5WidgetsforMobile(BuildContext context, MouseRegions _mouseregions, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.dynamicHeigth(0.015),),
        Text(
          _translate.ResultofTexts['page5Title1'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ), // HAKKIMDA
        Expanded(
          flex: 7,
          child: SizedBox.expand(
            child: Card(
              margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
              color: Colors.white,
              shadowColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeigth(0.05),),
                  child:
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: _translate.ResultofTexts['page5AboutMe1'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        TextSpan(
                          text: _translate.ResultofTexts['page5AboutMe2'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        TextSpan(
                          text: _translate.ResultofTexts['page5AboutMe3'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          _translate.ResultofTexts['page5Title2'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ), // TECRÜBELER BAŞLIĞI
        Expanded(
          flex: 7,
          child: GridView.count(
              mainAxisSpacing: context.dynamicHeigth(0.025),
              crossAxisSpacing: context.dynamicWidth(0.025),
              childAspectRatio: 1,
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              controller: _SkillsControllerforMobileGridView,
            children: [
              Card(
                margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
                color: Colors.white,
                shadowColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.dynamicHeigth(0.025),),
                    Text(_pagestext.page5SkillsTitle1, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: context.dynamicHeigth(0.01),
                        crossAxisSpacing: context.dynamicWidth(0.01),
                        childAspectRatio: 1,
                        padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.001), context.dynamicWidth(0.05), context.dynamicHeigth(0.001),),
                        crossAxisCount: 2,
                        children: List.generate(_myassets.skillsAssets.length, (index) {
                          return GestureDetector(
                            onTap: () async {
                              _ShowSnackbar(_myassets.skillsToolTips[index], 300);
                            },
                            child: SizedBox(
                              width: 25,
                              child: Image.asset(_myassets.skillsAssets[index], fit: BoxFit.fitWidth,),
                            ),
                          );
                        } ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
                color: Colors.white,
                shadowColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.dynamicHeigth(0.025),),
                    Text(_pagestext.page5SkillsTitle2, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: context.dynamicHeigth(0.01),
                        crossAxisSpacing: context.dynamicWidth(0.01),
                        childAspectRatio: 1,
                        padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.001), context.dynamicWidth(0.05), context.dynamicHeigth(0.001),),
                        crossAxisCount: 2,
                        children: List.generate(_myassets.backendAssets.length, (index) {
                          return GestureDetector(
                              onTap: () async {
                                _ShowSnackbar(_myassets.backendToolTips[index], 300);
                              },
                              child: SizedBox(
                              width: 25,
                              child: Image.asset(_myassets.backendAssets[index], fit: BoxFit.fitWidth,),
                            ),
                          );
                        } ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.025), context.dynamicWidth(0.05), context.dynamicHeigth(0.025),),
                color: Colors.white,
                shadowColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.dynamicHeigth(0.025),),
                    Text(_pagestext.page5SkillsTitle3, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: context.dynamicHeigth(0.01),
                        crossAxisSpacing: context.dynamicWidth(0.01),
                        childAspectRatio: 1,
                        padding: EdgeInsets.fromLTRB(context.dynamicWidth(0.05), context.dynamicHeigth(0.001), context.dynamicWidth(0.05), context.dynamicHeigth(0.001),),
                        crossAxisCount: 2,
                        children: List.generate(_myassets.extraAssets.length, (index) {
                          return GestureDetector(
                              onTap: () async {
                                _ShowSnackbar(_myassets.extraTooltips[index], 300);
                              },
                              child: SizedBox(
                              width: 25,
                              child: Image.asset(_myassets.extraAssets[index], fit: BoxFit.fitWidth,),
                            ),
                          );
                        } ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }

  //Mobile sayfada altıncı section: Bonus ve İletişim
  Widget Container6WidgetsforMobile(BuildContext context, Autoscroll _autoscroll, GoogleTranslateService _translate) {
    return Column(
      children: [
        Divider(thickness: 1, color: Colors.white,),
        SizedBox(height: context.dynamicHeigth(0.015),),
        Text('Bonus', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),),
        Expanded(
          flex: 15,
          child: Padding(
            padding:  EdgeInsets.all(context.dynamicWidth(0.025),),
            child: Column(
              spacing: context.dynamicHeigth(0.025),
              children: [
                Expanded(
                  child: Image.asset(_myassets.bonusAssets[_autoscroll.bonusAssetSlide], fit: BoxFit.contain,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: context.dynamicWidth(0.025),
                  children: [
                    IconButton(onPressed: () {
                      Provider.of<Autoscroll>(context, listen: false).BonusSlideDecrement();

                    }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,),),
                    IconButton(
                      onPressed: () {
                        Provider.of<Autoscroll>(context, listen: false).BonusSlideIncrement();

                      }, icon: Icon(Icons.arrow_forward_ios, color: Colors.white,),),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
            width: context.dynamicWidth(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: context.dynamicWidth(0.01),
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<Urlservices>(context, listen: false).openNewUrl(_pagestext.page6githubURL, 'new tab');
                  },
                  iconSize: kToolbarHeight,
                  icon: Image.asset(_myassets.communicationIconAssets[0],//Github IconButton
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<Urlservices>(context, listen: false).openNewUrl(_pagestext.page6linkedinURL, 'new tab');
                  },
                  iconSize: kToolbarHeight,
                  icon: Image.asset(_myassets.communicationIconAssets[1], //Linkedin Icon Button
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _ShowSnackbar('enghuseyingurel@gmail.com', 2000);
                  },
                  iconSize: kToolbarHeight,
                  icon: Image.asset(_myassets.communicationIconAssets[2], //Email Icon Button
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(child: Text(_translate.ResultofTexts['page6allrights'], style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),),
        ),
      ],
    );
  }

}
