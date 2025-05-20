import 'package:gaming_startup_ai_agent/core/api/api.dart';
import 'package:gaming_startup_ai_agent/core/service_result/service_result.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';

abstract class ChatRepository {
  Future<ApiResult<List<MessageResModel>>> getChatHistory(String sessionId);

  ApiResult<Stream<List<ChatResModel>>> getAllChatSessions(String username);

Future<ApiResult<MessageResModel>> continueChat({
    required String sessionId,
    required String query,
  });

  Future<ApiResult<MessageResModel>> startChat({
    required String username,
    required String agentType,
    required String query,
  });

  /*Future<ApiResult<ChatResModel>> createNewChatSession({
    required String username,
    required String title,
  });

  Future<ApiResult<bool>> deleteChatSession(String sessionId);*/

}
