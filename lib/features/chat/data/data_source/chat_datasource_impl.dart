import 'dart:async';

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
  Stream<List<ChatResModel>> getAllChatSessions(String username) {
    //get the list of all chat from firebase collection 'chat_history' where the document name contains username
    //and return the list of chat sessions

    /* return _firestore.collection('donations').snapshots().map((event) =>
        event.docs.map((e) => NewDonation.fromJson(e.data())).toList());*/

    return firestore.collection('chat_history').snapshots().map((event) {
      List<ChatResModel> chats =
          event.docs.map((e) {
            //print(e.id);
            return ChatResModel.fromString(e.id);
          }).toList();

      return chats.where((session) => session.username == username).toList();
    });
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

    MessageResModel message = MessageResModel.fromJson(response.data);

    return message;
  }

  @override
  Future<MessageResModel> startChat({
    required String username,
    required String agentType,
    required String query,
  }) async {
    final response = await _apiClient.post(
      '/start_chat',
      data: {'username': username, 'query': query, 'agentType': agentType},
    );

    await apiResponseChecker(response);

    MessageResModel chatHistory = MessageResModel.fromJson(response.data);

    return chatHistory;
  }

  /*@override
  Future<Stream<MessageResModel>> continueChatStream({required String sessionId, required String query})async{
    Response<ResponseBody>  rs = await Dio().get<ResponseBody>(
      "https://server/stream",
      options: Options(headers: {
        "Authorization":
        'vhdrjb token"',
        "Accept": "text/event-stream",
        "Cache-Control": "no-cache",
      }, responseType: ResponseType.stream), // set responseType to `stream`
    );
    StreamTransformer<Uint8List, List<int>> unit8Transformer =
    StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(List<int>.from(data));
      },
    );

    rs.data?.stream
        .transform(unit8Transformer)
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .listen((event) {


    });

    final response =  _apiClient.post(
      '/continue_chat',
      data: {'sessionId': sessionId, 'query': query},

    );

     apiResponseChecker(response);

    MessageResModel message = MessageResModel.fromJson(response.data);

    return message;
  }*/
}
