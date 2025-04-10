import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';

abstract class ChatDataSource {
  Future<List<MessageResModel>> getChatHistory(String sessionId);

  Future<List<ChatResModel>> getAllChatSessions(String username);

  Future<MessageResModel> continueChat({
    required String sessionId,
    required String query,
  });
}
