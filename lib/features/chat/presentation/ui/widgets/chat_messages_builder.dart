import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/ai_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/human_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/thinking_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatMessagesBuilder extends ConsumerWidget {
  const ChatMessagesBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatHistory = ref.watch(chatHistoryProvider);
    Size screenSize = MediaQuery.of(context).size;

    return ref.watch(selectedChatProvider) != null
        ? chatHistory.when(
          data: (x) {
            // x.removeAt(0);
            final data = x.reversed.toList();
            return Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 20),
              child: SizedBox(
                height: screenSize.height,
                child: ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAlias,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AiThinkingMessageBubble();
                    } else {
                      final currentData = data[index - 1];
                      switch (currentData.type) {
                        case ChatType.ai:
                          return AiMessageBubble(
                            message: currentData,
                            isThinking: false,
                          );
                        case ChatType.system:
                          return HumanMessageBubble(message: currentData);
                        case ChatType.human:
                          return HumanMessageBubble(message: currentData);
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
