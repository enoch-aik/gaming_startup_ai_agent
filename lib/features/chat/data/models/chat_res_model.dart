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

  String get rawData {
    return '$username' + '_' + '$sessionId' + '_' + timeStamp;
  }

  factory ChatResModel.fromString(String chat) {
    final parts = chat.split('_');
    final username = parts[0];
    final sessionId = parts[1];
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
      (double.parse(parts[2]) * 1000).toInt(),
    );

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
