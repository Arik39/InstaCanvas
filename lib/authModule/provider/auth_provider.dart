import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AuthProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('insta_canvas');

  Map<String, String> get selectedLanguage {
    return {
      'subTitle': 'Welcome to',
      'title': 'Insta Canvas',
      'usernameHintText': 'Enter Username without @',
      'history': 'history',
      'search': 'SEARCH',
      'files': 'Files',
      'download': 'Download',
      'settings': 'Settings',
      'general': 'General',
      'downloadPath': 'Download Path',
      'Select Language': 'Select Language',
      'ok': 'OK',
      'cancel': 'CANCEL',
      'deleteTitle': 'Are you sure you want to delete the photo ?',
      'downloadMsg': 'File Downloaded successfully to Download Folder',
    };
  }
}
