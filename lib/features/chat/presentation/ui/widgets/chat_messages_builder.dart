import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/ai_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/human_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/thinking_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatMessagesBuilder extends HookConsumerWidget {
  final ScrollController scrollController;
  final bool addTopSpacing;
  final bool isMobile;

  const ChatMessagesBuilder({
    super.key,
    required this.scrollController,
    this.addTopSpacing = true,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    final chatHistory = ref.watch(chatHistoryProvider);
    Size screenSize = MediaQuery.of(context).size;


    if (isMobile) {
      ref.listen<AsyncValue<List<ChatResModel>>>(
        getChatSessionFutureProvider(user.username),
            (previous, next) {
          if (next.value != null && previous?.value != null) {
            ChatResModel? newChat = next.value!.getNewChat(
              previous!.value!,
            );
            if (newChat != null) {
              ref.read(selectedChatProvider.notifier).state = newChat;
            }
          }
        },
      );
    }

    return ref.watch(selectedChatProvider) != null
        ? chatHistory.when(
          data: (x) {
            // x.removeAt(0);
            final data = x.reversed.toList();
            return Padding(
              padding: EdgeInsets.only(bottom: 50, top: addTopSpacing ? 20 : 0),
              child: SizedBox(
                height: screenSize.height,
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    right: 16,
                    bottom: 8,
                    left: addTopSpacing ? 16 : 0,
                  ),
                  reverse: true,
                  shrinkWrap: true,
                  controller: scrollController,
                  clipBehavior: Clip.antiAlias,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    bool isLast = index == data.length - 1;
                    if (index == 0) {
                      return AiThinkingMessageBubble();
                    } else {
                      final currentData = data[index - 1];
                      switch (currentData.type) {
                        case ChatType.ai:
                          return AiMessageBubble(
                            message: currentData,
                            isThinking: false,
                            isLast: isLast,
                            isMobile: isMobile,
                          );
                        case ChatType.system:
                          return SizedBox();
                        case ChatType.human:
                          return HumanMessageBubble(
                            message: currentData,
                            isMobile: isMobile,
                          );
                      }
                    }
                    return Text(data[index].content);
                    //subtitle: Text(data[index].createdAt.toString()),
                  },
                  separatorBuilder: (context, index) {
                    return ColSpacing(24);
                  },
                  itemCount: data.length + 1,
                ),
              ),
            );
          },
          error: (e, stackTrace) {
            /*throw Exception(
                          'Unable to retrieve chat history: ${e.toString()}',
                        );*/
            return Center(
              child: Text(
                'Unable to retrieve chat history: ${e.toString()}' +
                    '${stackTrace}',
              ),
            );
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        )
        : SizedBox();
  }
}
