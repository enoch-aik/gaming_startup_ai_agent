import 'package:equatable/equatable.dart';

class ChatResModel extends Equatable {
  final String username;
  final String sessionId;
  final DateTime createdAt;
  final String timeStamp;

  const ChatResModel({
    required this.username,
    required this.sessionId,
    required this.createdAt,
    required this.timeStamp,
  });

  @override
  String toString() {
    return 'ChatResModel{username: $username, sessionId: $sessionId, createdAt: $createdAt, timeStamp: $timeStamp}';
  }

  String get rawData {
    return '$username' + '_' + '$sessionId' + '_' + timeStamp;
  }

  factory ChatResModel.fromString(String chat) {
    final parts = chat.split('_');
    final username = parts[0];
    final sessionId = parts[1];
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
      ((double.tryParse(parts[2])??1745824165.785427) * 1000).toInt(),
    );

    print(parts [1]);

    return ChatResModel(
      username: username,
      sessionId: sessionId,
      createdAt: createdAt,
      timeStamp: parts[2],
    );
  }

  @override
  List<Object?> get props => [username, sessionId, createdAt, timeStamp];
}

extension ChatListExtension on List<ChatResModel> {
  //get the new chat that was added when two lists of chats are compared
  ChatResModel? getNewChat(List<ChatResModel> oldList) {
    if (isEmpty) return null;
    for (var chat in this) {
      if (!oldList.contains(chat)) {
        return chat;
      }
    }
    return null;
  }
}
