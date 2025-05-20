import 'package:gaming_startup_ai_agent/core/interceptor/api_interceptor.dart';
import 'package:gaming_startup_ai_agent/core/service_result/src/api_result.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/data_source/chat_datasource_impl.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/domain/repo/chat_repo.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRepositoryImplementation extends ChatRepository {
  final Ref ref;

  ChatRepositoryImplementation({required this.ref});

  late final ChatDataSourceImplementation chatDataSource = ref.read(
    chatDataSourceProvider,
  );

  @override
  ApiResult<Stream<List<ChatResModel>>> getAllChatSessions(String username) =>
      streamInterceptor(() => chatDataSource.getAllChatSessions(username));

  @override
  Future<ApiResult<List<MessageResModel>>> getChatHistory(String sessionId) =>
      apiInterceptor(() => chatDataSource.getChatHistory(sessionId));

  @override
  Future<ApiResult<MessageResModel>> continueChat({
    required String sessionId,
    required String query,
  }) => apiInterceptor(
    () => chatDataSource.continueChat(sessionId: sessionId, query: query),
  );

  @override
  Future<ApiResult<MessageResModel>> startChat({
    required String username,
    required String agentType,
    required String query,
  }) => apiInterceptor(
    () => chatDataSource.startChat(
      username: username,
      agentType: agentType,
      query: query,
    ),
  );
}
