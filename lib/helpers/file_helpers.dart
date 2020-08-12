import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> getDocumentDirectory({String folder = ''}) async {
  Directory baseDir;
  if (Platform.isAndroid) {
    baseDir = await getExternalStorageDirectory();
  } else {
    baseDir = await getApplicationDocumentsDirectory();
  }
  return baseDir.path + '/' + folder;
}

Future<void> createAppDirectories() async {
  String rootDir = await getDocumentDirectory();
  List<String> dirToBeCreated = ['$rootDir/audio', '$rootDir/pictures'];

  dirToBeCreated.forEach((path) async {
    var dir = Directory(path);
    bool dirExists = await dir.exists();
    if (!dirExists) {
      dir.create();
    }
  });
}
