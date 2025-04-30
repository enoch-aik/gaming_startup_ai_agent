import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';

abstract class ChatDataSource {
  Future<List<MessageResModel>> getChatHistory(String sessionId);

  Stream<List<ChatResModel>> getAllChatSessions(String username);

  Future<MessageResModel> continueChat({
    required String sessionId,
    required String query,
  });

 /* Future<Stream<MessageResModel>> continueChatStream({
    required String sessionId,
    required String query,
  });*/

  Future<MessageResModel> startChat({
    required String username,
    required String agentType,
    required String query,
  });
}
