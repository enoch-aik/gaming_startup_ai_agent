import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/core/helper/api_response_checker.dart';
import 'package:gaming_startup_ai_agent/core/services/api/api_client.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/data_source/chat_datasource.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatDataSourceImplementation extends ChatDataSource {
  final Ref ref;
  final FirebaseFirestore firestore;

  late final ApiClient _apiClient = ref.read(apiClientProvider);

  ChatDataSourceImplementation({required this.ref, required this.firestore});

  @override
  Future<List<ChatResModel>> getAllChatSessions(String username) async {
    //get the list of all chat from firebase collection 'chat_history' where the document name contains username
    //and return the list of chat sessions

    final data = await firestore.collection('chat_history').get();

    //get the list of all chat sessions
    final List<ChatResModel> chatSessions =
        data.docs.map((e) => ChatResModel.fromString(e.id)).toList();

    List<ChatResModel> userChatSessions =
        chatSessions.toList().where((session) {
          return session.username == username;
        }).toList();

    return userChatSessions;
  }

  @override
  Future<List<MessageResModel>> getChatHistory(String sessionId) async {
    final response = await _apiClient.post(
      '/chat_history',
      data: {'sessionId': sessionId},
    );
    await apiResponseChecker(response);
    List<MessageResModel> chatHistory =
        response.data['data']
            .map<MessageResModel>((e) => MessageResModel.fromJson(e))
            .toList();

    return chatHistory;
  }

  @override
  Future<MessageResModel> continueChat({
    required String sessionId,
    required String query,
  }) async {
    final response = await _apiClient.post(
      '/continue_chat',
      data: {'sessionId': sessionId, 'query': query},
    );

    await apiResponseChecker(response);

    MessageResModel chatHistory = MessageResModel.fromJson(
      response.data,
    );

    return chatHistory;
  }
}
