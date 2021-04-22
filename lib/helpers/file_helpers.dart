import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileHelper {

  static String collectionsFolder = '';
  static String baseFolder = '';

  static Future<String> getDocumentDirectory() async {
    Directory baseDir;
    if (Platform.isAndroid) {
      try {
        // baseDir = Directory((await PathProviderEx.getStorageInfo()).first.rootDir);
        baseDir = await getExternalStorageDirectory();
      } on PlatformException {
        baseDir = await getExternalStorageDirectory();
      }
    } else {
      baseDir = await getApplicationDocumentsDirectory();
    }
    return baseDir.path;
  }

  static Future<void> createAppDirectories() async {
    if (await Permission.storage .request() .isGranted) {
      baseFolder = await getDocumentDirectory();
      // collectionsFolder = rootDir;
      //
      // List<String> dirToBeCreated = [collectionsFolder];
      //
      // dirToBeCreated.forEach((path) async {
      //   var dir = Directory(path);
      //   bool dirExists = await dir.exists();
      //   if (!dirExists) {
      //     dir.create();
      //   }
      // });
    }
  }
}