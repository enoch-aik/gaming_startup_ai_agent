import 'dart:async';

import 'package:gaming_startup_ai_agent/core/service_exceptions/service_exception.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageState extends AsyncNotifier<List<MessageResModel>> {
  late final chatRepo = ref.read(chatRepoProvider);
  late ChatResModel selectedChat;
  late final UserAuthInformation user = ref.watch(currentUserDetails)!;

  //create an internal state
  late AsyncValue<List<MessageResModel>> _state = AsyncLoading();

  late bool thinking = false;

  late bool newChat = true;

  bool get isThinking => thinking;

  @override
  FutureOr<List<MessageResModel>> build() async {
   // await Future.delayed(Duration(milliseconds: 500));
    selectedChat = ref.watch(selectedChatProvider)!;

    final result = await chatRepo.getChatHistory(selectedChat.rawData);

    result.when(
      success: (data) {
        updateNewChatState(false);
        state = AsyncData(data);
        _state = AsyncData(data);
        return data;
      },
      apiFailure: (e, _) {
        //throw  Exception(e.message);

        //print(e.message);
        state = AsyncData([]);
        _state = AsyncData([]);
        return [];
      },
    );
    return state.value ?? [];
  }

  FutureOr<void> continueChat({required String query}) async {
    updateThinkingState(true);
    MessageResModel humanMessage = MessageResModel(
      content: query,
      type: ChatType.human,
    );
    state = AsyncData([...state.value ?? [], humanMessage]);
    _state = AsyncData([...state.value ?? [], humanMessage]);

    final result = await chatRepo.continueChat(
      sessionId: selectedChat.rawData,
      query: query,
    );

    result.when(
      success: (data) {
        updateThinkingState(false);
        state = AsyncData([...state.value ?? [], data]);
        _state = AsyncData([...state.value ?? [], data]);
      },
      apiFailure: (e, _) {
        updateThinkingState(false);
        state = AsyncData([...state.value ?? [], MessageResModel.error()]);
        _state = AsyncData([...state.value ?? [], MessageResModel.error()]);
      },
    );
  }

  FutureOr<void> startChat({
    required String query,
    required String agentType,
  }) async {
    //clear chat history
    clearChat();

    MessageResModel humanMessage = MessageResModel(
      content: query,
      type: ChatType.human,
    );

    state = AsyncData([humanMessage]);
    _state = AsyncData([humanMessage]);
    updateThinkingState(true);

    final result = await chatRepo.startChat(
      username: user.username,
      agentType: agentType,
      query: query,
    );

    result.when(
      success: (data) {
        updateThinkingState(false);
        state = AsyncData([...?state.value, data]);
        _state = AsyncData([...?_state.value, data]);
      },
      apiFailure: (e, _) {
        updateThinkingState(false);
        state = AsyncData([...?state.value, MessageResModel.error()]);
        _state = AsyncData([...?state.value, MessageResModel.error()]);
      },
    );
  }

  FutureOr<void> clearChat() async {
    updateThinkingState(false);
    state = AsyncData([]);
    _state = AsyncData([]);
    updateNewChatState(true);
  }

  //update state to loading
  void updateStateToLoading() {
    state = const AsyncLoading();
  }

  void retrieveInternalState() {
    state = AsyncData(_state.value ?? []);
  }

  //update thinking state
  void updateThinkingState(bool value) {
    thinking = value;
  }

  //update new chat state
  void updateNewChatState(bool value) {
    newChat = value;
  }
}
