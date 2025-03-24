

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfolio/viewmodels/secrets.dart';


class DatabaseService  extends SecretKeys with ChangeNotifier {

  final StringuserAPIKey = SecretKeys().userAPIKey;
  final DatabaseReference _dbref = FirebaseDatabase.instance.ref();
  int _readCount = 0;
  var data;


  Future<void> GetUserInformations()  async {

    final snapshot = await _dbref.child('enteredCounter').get();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);

    if(snapshot.exists) {
      _readCount = snapshot.value as int;
      _readCount++;
      _dbref.child('enteredCounter').set(_readCount);
    }

    final response = await http.get(Uri.parse(StringuserAPIKey));


    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    print('Running on ${webBrowserInfo.userAgent}');

    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      print("No Data.");
    }


    String parentbase = DateFormat("yyyyMMdd").format(now);
    String _datakey = _dbref.push().key.toString();

    await _dbref.child('enteredInfos').child(parentbase).child(_datakey).set({
      'data1': '${webBrowserInfo.userAgent}',
      'data2': '${data['region']}',
      'data3': '${data['org']}',
      'data4': formattedDate,
    });

    notifyListeners();
  }

  Future<void> GetUserInformations2()  async {


    final snapshot = await _dbref.child('examinedCounter').get();

    if(snapshot.exists) {
      _readCount = snapshot.value as int;
      _readCount++;
      _dbref.child('examinedCounter').set(_readCount);
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);

    final response = await http.get(Uri.parse(StringuserAPIKey));


    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    print('Running on ${webBrowserInfo.userAgent}');

    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      print("No Data");
    }


    String parentbase = DateFormat("yyyyMMdd").format(now);
    String _datakey = _dbref.push().key.toString();

    await _dbref.child('examined').child(parentbase).child(_datakey).set({
      'data1': '${webBrowserInfo.userAgent}',
      'data2': '${data['region']}',
      'data3': '${data['org']}',
      'data4': formattedDate,
    });

    notifyListeners();
  }

  Future<void> TbookClicked() async {
    int _data = 0;
    final snapshot = await _dbref.child('tbookClicked').get();
    if(snapshot.exists) {
      _data = snapshot.value as int;
      _data++;
      _dbref.child('tbookClicked').set(_data);
    }
  }

  Future<void> MbookClicked() async {
    int _data = 0;
    final snapshot = await _dbref.child('mbookClicked').get();
    if(snapshot.exists) {
      _data = snapshot.value as int;
      _data++;
      _dbref.child('mbookClicked').set(_data);
    }
  }

  Future<void> KbookClicked() async {
    int _data = 0;
    final snapshot = await _dbref.child('kbookClicked').get();
    if(snapshot.exists) {
      _data = snapshot.value as int;
      _data++;
      _dbref.child('kbookClicked').set(_data);
    }
  }

  Future<void> NbookClicked() async {
    int _data = 0;
    final snapshot = await _dbref.child('nbookClicked').get();
    if(snapshot.exists) {
      _data = snapshot.value as int;
      _data++;
      _dbref.child('nbookClicked').set(_data);
    }
  }

  Future<void> TeleportalClicked() async {
    int _data = 0;
    final snapshot = await _dbref.child('teleportalClicked').get();
    if(snapshot.exists) {
      _data = snapshot.value as int;
      _data++;
      _dbref.child('teleportalClicked').set(_data);
    }
  }

  Future<void> PortfolioClicked() async {
    int _data = 0;
    final snapshot = await _dbref.child('portfolioClicked').get();
    if(snapshot.exists) {
      _data = snapshot.value as int;
      _data++;
      _dbref.child('portfolioClicked').set(_data);
    }
  }



}