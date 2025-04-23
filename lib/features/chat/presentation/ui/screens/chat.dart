import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_messages_builder.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_session_list.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_textfield.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/user_profile.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    //create a listener for chatSession so that once another chat session is added, it automatically updates the selectedChat to the new session

    /* ref.listen<AsyncValue<List<ChatResModel>>>(
      getChatSessionFutureProvider(user.username),
      (previous, next) {
        if (next.value != null) {
          ref.read(selectedChatProvider.notifier).state = next.value!.first;
        }
      },
    );*/

    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 340,
              height: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: context.primary),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: context.primaryContainer.withValues(
                      colorSpace: ColorSpace.sRGB,
                    ),
                  ),
                ],
              ),
              child: Stack(children: [ChatSessionList(), UserProfile()]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16, right: 16),
              child: Stack(children: [ChatMessagesBuilder(), ChatTextfield()]),
            ),
          ),
        ],
      ),
    );
  }
}
