import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


class Urlservices with ChangeNotifier {



Future<void> openNewUrl(String url, String mode) async {




  if(mode == '_self') {
    if (await canLaunchUrl(Uri.parse(url))) {
    //  await launchUrl(Uri.parse(url), webOnlyWindowName: mode);

      await launchUrl(Uri.parse(url), webOnlyWindowName: '_self' );
      notifyListeners();
    }
  }
  else {

      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); // Opens in a new tab
      notifyListeners();

  }


}


}