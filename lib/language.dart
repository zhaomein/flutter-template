import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLg {  
  AppLg(this.locale);  
  
  final Locale locale;  
  
  static AppLg of(BuildContext context) {  
    return Localizations.of<AppLg>(context, AppLg);  
  }  
  
  Map<String, String> _sentences;  
  
  Future<bool> load() async {
    String data = await rootBundle.loadString('assets/languages/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }
  
  String trans(String key) {  
    return _sentences.containsKey(key) ? _sentences[key] : key;  
  }  
}


class AppLocalizationsDelegate extends LocalizationsDelegate<AppLg> {  
  const AppLocalizationsDelegate();  
  
  @override  
  bool isSupported(Locale locale) => ['vi'].contains(locale.languageCode);  
  
  @override  
  Future<AppLg> load(Locale locale) async {  
    AppLg localizations = new AppLg(locale);  
    await localizations.load();  
    
    print("Load ${locale.languageCode}");  
    
    return localizations;  
  }  
  
  @override  
  bool shouldReload(AppLocalizationsDelegate old) => false;  
}