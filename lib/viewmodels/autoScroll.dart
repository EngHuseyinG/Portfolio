import 'package:flutter/material.dart';

class Autoscroll with ChangeNotifier {
  int _index = 1;
  bool _scrolled = false;
  double _currentScrollPosition = 0.0;
  double _profilePhotoSize = 0.0;
  double _mobileappCardScale = 0.0;
  double _webappCardScale = 0.0;
  double _moduleCardScale = 0.0;
  int _showedModuleAsset = 0;
  int _bonusAssetSlide = 0;



  int get index => _index;
  bool get scrolled => _scrolled;
  double get currentScrollPosition  => _currentScrollPosition;
  double get mobileappCardScale => _mobileappCardScale;
  double get webappCardScale => _webappCardScale;
  double get profilePhotoSize => _profilePhotoSize;
  double get moduleCardScale => _moduleCardScale;
  int get showedModuleAsset => _showedModuleAsset;
  int get bonusAssetSlide => _bonusAssetSlide;


void GotoIndex(int goal) {

    _index = goal;
    _scrolled = true;
    notifyListeners();
}

  void WenttoIndex()  {
    _scrolled = false;
    notifyListeners();
}

  void UpdateCurrentScrollPosition(double CurrentPosition) {
    _currentScrollPosition = CurrentPosition;
        notifyListeners();
  }

  void UpdateProfilePhotoScale(double newProfilePhotoScale) {
    _profilePhotoSize = newProfilePhotoScale;
    notifyListeners();
  }

  void GrowupMobileAppCard(double newMobileappCardScale) {
    _mobileappCardScale = newMobileappCardScale;
    notifyListeners();
  }

  void GrowupWebAppCard(double newWebappCardScale) {
    _webappCardScale = newWebappCardScale;
    notifyListeners();
  }

  void GrowupModuleCard(double newModuleCardScale) {
    _moduleCardScale = newModuleCardScale;
    notifyListeners();
  }

  void UpdateModuleAsset(int index) {
    _showedModuleAsset = index;
    notifyListeners();
  }

  void BonusSlideIncrement() {
  if(_bonusAssetSlide == 5) {
    _bonusAssetSlide = 0;
  }
  else {
    ++_bonusAssetSlide;
  }
  notifyListeners();
  }

  void BonusSlideDecrement() {
    if(_bonusAssetSlide == 0) {
      _bonusAssetSlide = 5;
    }
    else {
      --_bonusAssetSlide;
    }
    notifyListeners();
  }


}