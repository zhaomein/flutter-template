//import 'dart:async';
//
//import 'package:com.codestage.appchat/extensions/dynamic_extension.dart';
//import 'package:flutter_sound_lite/flutter_sound.dart';
//
//import 'file_helpers.dart';
//
//
//class AudioPlayer {
//  static final AudioPlayer _singleton = AudioPlayer._internal();
//  static AudioPlayer getInstance() => _singleton;
//  AudioPlayer._internal();
//
//  StreamController _durationCtrl = StreamController.broadcast();
//  FlutterSoundPlayer _soundPlayer;
//  bool _isPlaying = true;
//
//  bool get isPlaying => _isPlaying;
//  Stream get durationStream => _durationCtrl.stream;
//
//  Future<void> play(String path) async {
//    assert(path != null && path.isNotEmpty);
//    Completer completer = Completer();
//
//    if(_isPlaying) {
//      stop();
//    }
//
//    if(_soundPlayer != null) {
//      await _soundPlayer.closeAudioSession();
//    }
//    _soundPlayer = await FlutterSoundPlayer().openAudioSession();
//    print('$tag: Play audio at $path');
//    await _soundPlayer.setSubscriptionDuration(Duration(milliseconds: 100));
//    await _soundPlayer.startPlayer(
//        fromURI: path,
//        whenFinished: () {
//          _isPlaying = false;
//          completer.complete();
//        }
//    );
//
//    _soundPlayer.onProgress.listen((e) {
//      if(e != null) {
//        _durationCtrl.sink.add(e);
//      }
//    });
//
//    return completer.future;
//  }
//
//  Future<String> getAudioPath(String name) async {
//    String folderPath = await getDocumentDirectory(folder: 'audio');
//    return folderPath + '/' + name;
//  }
//
//  void stop() {
//    if(_soundPlayer != null) {
//      _soundPlayer.stopPlayer();
//      _soundPlayer.closeAudioSession();
//    }
//    _isPlaying = false;
//  }
//
//  void close() {
//    _durationCtrl.close();
//  }
//}