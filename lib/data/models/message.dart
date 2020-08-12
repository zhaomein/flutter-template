import 'dart:convert';

import 'base/model.dart';
import '../../extensions/datetime_extension.dart';

import 'base/column_types.dart';

class MessageStatus {
  static const FINISH = 'finish';
  static const DOWNLOADING = 'downloading';
  static const UPLOADING = 'uploading';
  static const ERROR = 'error';
}

class Message extends Model {
  static String table = 'messages';
  
  static const String TEXT = 'text';
  static const String IMAGE = 'image';
  static const String AUDIO = 'audio';
  
  String id;
  String content;
  String type;
  String roomId;
  String status;
  DateTime createdAt;
  String senderId;

  Message({this.id, this.content, this.createdAt, this.type = TEXT, this.senderId, this.status, this.roomId});

  static Map<String, dynamic> tableColumns = {
    '_id': [ColumnType.text, ColumnType.primaryKey],
    'type': ColumnType.text,
    'content': ColumnType.text,
    'status': ColumnType.text,
    'room_id': ColumnType.text,
    'created_by': ColumnType.text,
    'created_at': ColumnType.text
  };

  static Message fromMap(Map<String, dynamic> map) {
    if(map == null || map.isEmpty) {
      return Message(
        content: '',
        createdAt: DateTime.now()
      );
    }

    return Message(
        id: map['_id'] ?? '',
        content: map['content'] ?? '',
        type: map['type'] ?? '',
        status: map['status'] ?? MessageStatus.FINISH,
        senderId: map['created_by'] ?? '',
        createdAt: map['created_at'] != null && map['created_at'].isNotEmpty
              ? DateTime.parse(map['created_at']).toLocal() : DateTime.now()
    );
  }

  @override
  Map<String, dynamic> get asMap => {
    '_id': id,
    'content': content,
    'status': status ?? '',
    'type': type ?? 'text',
    'room_id': roomId ?? '',
    'created_by': senderId,
    'created_at': createdAt.format("yyyy-MM-dd HH:mm:ss")
  };

  @override
  String get rowId => id;

  @override
  String get tableName => table;

  Map<String, dynamic> getAudioMeta() {
    var content = json.decode(this.content);
    return {
      'length': DateTime.fromMillisecondsSinceEpoch(content['length'] * 1000),
      'name': content['name']
    };
  }

}