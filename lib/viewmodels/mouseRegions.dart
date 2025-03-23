

import 'package:flutter/material.dart';

class MouseRegions with ChangeNotifier {

  int _mobileAppMouseregion = 99;
  int _mobileStickerMouseregion = 99;
  int _webAppMouseregion = 99;
  int _webStickerMouseregions = 99;
  bool _moduleCardHovered = false;
  int _modulePictureregion = 99;

  int get mobileAppMouseregion => _mobileAppMouseregion;
  int get mobileStickerMouseRegion => _mobileStickerMouseregion;
  int get webAppMouseregion => _webAppMouseregion;
  int get webStickerMouseRegion => _webStickerMouseregions;
  int get modulePictureregion => _modulePictureregion;
  bool get moduleCardHovered => _moduleCardHovered;

  void MobileAppHovered(int index) {
    _mobileAppMouseregion = index;
    notifyListeners();
  }

  void MobileStickerHovered(int index) {
    _mobileStickerMouseregion = index;
    notifyListeners();
  }

  void WebAppHovered(int index) {
    _webAppMouseregion = index;
    notifyListeners();
  }

  void WebStickerHovered(int index) {
    _webStickerMouseregions = index;
    notifyListeners();
  }

  void ModulePictureHovered(int index) {
    _modulePictureregion = index;
    notifyListeners();
  }

  void ModuleCardHovered(bool index) {
    _moduleCardHovered = index;
    notifyListeners();
  }





}