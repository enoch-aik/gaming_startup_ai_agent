import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

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

  //get all chat list, and create a chat_export(date).txt file and allow download
  Future<void> exportChatHistory() async {
    //get storage directory of the device

    final directory = await getTemporaryDirectory();
    final currentUser = ref.read(currentUserDetails)?.username ?? 'user';
    final currentDateInDDMMYYYY = DateTime.now()
        .toIso8601String()
        .split('T')
        .first
        .replaceAll('-', '');
    final File file = File(
      '${directory.path}/chat_export_$currentUser' +
          '_' +
          '$currentDateInDDMMYYYY.txt',
    );

    final allChats = state.value!;
    StringBuffer buffer = StringBuffer();
    for (var message in allChats) {
      String sender = message.type == ChatType.human ? "User" : "AI";
      buffer.writeln("$sender: ${message.content}\n");
    }

    //create a .txt file and allow download
    //await file.writeAsString(buffer.toString());
    //return file;

    final bytes = utf8.encode(buffer.toString());

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
        html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download =
              'chat_history ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}.txt';
    html.document.body!.children.add(anchor);

    // download
    anchor.click();

    // cleanup
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  /// Export chat messages to a txt file for Flutter Web
  /// Downloads a formatted text file containing the conversation history
  Future<void> exportChatToTxt() async {
    // Get the current chat messages
    final messages = state.value ?? [];

    if (messages.isEmpty) {
      // No messages to export
      return;
    }

    // Get current user and generate timestamp
    final currentUser = ref.read(currentUserDetails)?.username ?? 'user';
    final now = DateTime.now();
    final dateStr =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';

    // Create a formatted text buffer
    final buffer = StringBuffer();

    // Add header
    buffer.writeln('=' * 60);
    buffer.writeln('Chat Export - $currentUser');
    buffer.writeln('Date: ${now.day}/${now.month}/${now.year}');
    buffer.writeln(
      'Time: ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
    );
    if (selectedChat.sessionId.isNotEmpty) {
      buffer.writeln('Chat: ${selectedChat.rawData}');
    }
    buffer.writeln('=' * 60);
    buffer.writeln();

    // Add messages
    for (var i = 0; i < messages.length; i++) {
      final message = messages[i];
      final sender = message.type == ChatType.human ? 'You' : 'AI Assistant';

      buffer.writeln('[$sender]');
      buffer.writeln(message.content);
      buffer.writeln();

      // Add separator between messages (but not after the last one)
      if (i < messages.length - 1) {
        buffer.writeln('-' * 60);
        buffer.writeln();
      }
    }

    // Add footer
    buffer.writeln();
    buffer.writeln('=' * 60);
    buffer.writeln('End of Chat');
    buffer.writeln('Total Messages: ${messages.length}');
    buffer.writeln('=' * 60);

    // Convert to bytes and create blob for download
    final bytes = utf8.encode(buffer.toString());
    final blob = html.Blob([bytes], 'text/plain');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create download link and trigger download
    final fileName =
        '${currentUser}_${selectedChat.sessionId}_${dateStr}_$timeStr.txt';
    final anchor =
        html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = fileName;

    html.document.body!.children.add(anchor);
    anchor.click();

    // Cleanup
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
