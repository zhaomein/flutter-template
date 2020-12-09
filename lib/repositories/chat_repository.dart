abstract class _ChatRepository {
  //TODO: define methods of chat repository
}


class ChatRepository implements _ChatRepository {
  String token;

  static final ChatRepository _singleton = ChatRepository._internal();
  static ChatRepository getInstance() => _singleton;

  ChatRepository._internal();

  static ChatRepository initialize(String token) {
    _singleton.token = token;
    return _singleton;
  }
}