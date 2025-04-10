import 'dart:async';

import 'package:gaming_startup_ai_agent/core/service_exceptions/service_exception.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageState extends AsyncNotifier<List<MessageResModel>> {
  late final chatRepo = ref.read(chatRepoProvider);
  late final ChatResModel selectedChat = ref.watch(selectedChatProvider)!;

  @override
  FutureOr<List<MessageResModel>> build() async {
    final result = await chatRepo.getChatHistory(selectedChat.rawData);

    result.when(
      success: (data) {
        state = AsyncData(data);
        return data;
      },
      apiFailure: (e, _) {
        print(e.message);
        state = AsyncData([]);
        return [];
      },
    );
    return state.value ?? [];
  }

  FutureOr<void> continueChat({
    required String query,
  }) async {
    MessageResModel humanMessage = MessageResModel(content: query, type: ChatType.human);
    state = AsyncData([...state.value ?? [], humanMessage]);

    final result = await chatRepo.continueChat(
      sessionId: selectedChat.rawData,
      query: query,
    );

    result.when(
      success: (data) {
        state = AsyncData([...state.value ?? [], data]);
      },
      apiFailure: (e, _) {


      },
    );
  }
}
