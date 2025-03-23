import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/constants/text/pagesTextTR.dart';
import 'package:portfolio/viewmodels/secrets.dart';

class GoogleTranslateService extends SecretKeys with ChangeNotifier{

  final String apiKey = SecretKeys().googleTranslateAPIKey;

  bool _loadingTranslator = true;


  Pagestext _pagestext = Pagestext(); // Metinlerin orjinal Türkçe halleri bu class içindeki Map'ten alınır

  Map<String,String> _ResultofTexts = {};
  List<String> textKeys = [];
  List<String> textValues = [];

   // Metinlerin Türkçe hallerini veya İngilizceye çevrilmiş hallerini Sayfada bu Map ile kullanacağız
  Map get ResultofTexts => _ResultofTexts;
  bool get loadingTranslator => _loadingTranslator;

  Future translateText(bool TranslatetoEN) async {
    final String url =
        "https://translation.googleapis.com/language/translate/v2?key=$apiKey";

    textKeys = _pagestext.AllTextforTranslator.keys.toList(); // Metinlerin orjinal Türkçe hallerinin keylerini yeni bir listeye eşitleriz
    textValues = _pagestext.AllTextforTranslator.values.toList(); // Metinlerin orjinal Türkçe hallerini yeni bir listeye eşitleriz
    // Eğer sayfa ingilizce modundaysa Google Translator API ile çeviriyoruz

    if(TranslatetoEN == true) {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "q": textValues, // Çevrilecek metin
          "source": "tr",
          "target": 'en', // Hedef dil (tr = Türkçe, en = İngilizce)
          "format": "text",
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);  // Bu, Google Translator Rest API ile ingilizce metinleri aldığımız kısım
        List<String> _translatedValues = [];
        for(var i=0; i < textValues.length; i++) {
          _translatedValues.add(data['data']['translations'][i]['translatedText']);
        }
        _ResultofTexts = Map.fromIterables(textKeys, _translatedValues);
      } else {
        throw Exception("Translation failed: ${response.body}");
      }

    }
    //Eğer sayfa TR modunda ise
    else {
       _ResultofTexts = Map.fromIterables(textKeys, textValues); // PagesText Sınıfında bulunan metinlerin orjinal Türkçe değerleri atandı

    }
    _loadingTranslator = false;
    notifyListeners();

  }

  void TranslatorStarted() {
    _loadingTranslator = true;
    notifyListeners();
  }
}


/*

https://cloud.google.com/translate/docs/basic/translating-text    for REST API informations

    {
"data": {
"translations": [
{
"translatedText": "Hallo Welt",
"detectedSourceLanguage": "en"
},
{
"translatedText": "Mein Name ist Jeff",
"detectedSourceLanguage": "en"
}]}}
*/
