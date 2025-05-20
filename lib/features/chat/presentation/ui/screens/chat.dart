import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_messages_builder.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_session_list.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_textfield.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/user_profile.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    final scrollController = useScrollController();
    //create a listener for chatSession so that once another chat session is added, it automatically updates the selectedChat to the new session

    /* ref.listen<AsyncValue<List<ChatResModel>>>(
      getChatSessionFutureProvider(user.username),
      (previous, next) {
        if (next.value != null) {
          ref.read(selectedChatProvider.notifier).state = next.value!.first;
        }
      },
    );*/


    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        Size screenSize = MediaQuery.of(context).size;

        return isMobile
            ? Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Icon(Icons.edit_note_rounded, size: 32),
                      onTap: () {
                        ref.read(selectedChatProvider.notifier).state = null;
                        ref.read(chatHistoryProvider.notifier).clearChat();
                        ref
                            .read(chatHistoryProvider.notifier)
                            .updateNewChatState(true);
                      },
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Stack(
                    children: [
                      ChatSessionList(isMobile: true),
                      UserProfile(borderRadius: 16),
                    ],
                  ),
                ),
              ),
              body: SizedBox(
                height: screenSize.height,
                child: Stack(
                  children: [
                    ChatMessagesBuilder(
                      scrollController: scrollController,
                      isMobile: true,
                    ),
                    ChatTextfield(
                      scrollController: scrollController,
                      leftPadding: 16,
                      isMobile: true,
                    ),
                  ],
                ),
              ),
            )
            : Scaffold(
              body: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 340,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: context.primary),
                          boxShadow: [
                            BoxShadow(
                              color: context.primaryContainer.withValues(
                                colorSpace: ColorSpace.sRGB,
                              ),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [ChatSessionList(), UserProfile()],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        ChatMessagesBuilder(scrollController: scrollController),
                        ChatTextfield(scrollController: scrollController),
                      ],
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
