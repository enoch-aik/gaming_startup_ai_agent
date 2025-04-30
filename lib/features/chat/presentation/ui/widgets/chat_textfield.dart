import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/supported_agent.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/res/styles/styles.dart';
import 'package:gaming_startup_ai_agent/src/widgets/text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatTextfield extends HookConsumerWidget {
  final ScrollController scrollController;

  const ChatTextfield({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTextController = useTextEditingController();

    final ValueNotifier<SupportedAgent?> selectedAgent = useState(null);
    return Padding(
      padding:  EdgeInsets.only(right: 16,bottom: 16),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 5,
              color: context.primaryContainer.withOpacity(0.15),
            ),
          ),
          child: TextField(
            controller: chatTextController,
            maxLines: 7,
            minLines: 1,
            textInputAction: TextInputAction.send,
            onSubmitted: (value) async {
              String query = chatTextController.text;
              chatTextController.clear();
              bool isNewChat = ref.read(chatHistoryProvider.notifier).newChat;

              if (query.isNotEmpty) {
                isNewChat
                    ? await ref
                        .read(chatHistoryProvider.notifier)
                        .startChat(
                          query: query,
                          agentType: selectedAgent.value?.type.name ?? 'default',
                        )
                    : await ref
                        .read(chatHistoryProvider.notifier)
                        .continueChat(query: query);
              }
            },
            decoration: InputDecoration(
              hintFadeDuration: const Duration(milliseconds: 500),
              contentPadding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 4,
                bottom: 4,
              ),
              hintText:
                  (selectedAgent.value) != null
                      ? selectedAgent.value!.hintText
                      : ref.read(chatHistoryProvider.notifier).newChat
                      ? 'Ask me anything related to games'
                      : 'Type your message here',
              hintStyle: AppStyles.textStyle.copyWith(fontSize: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

             /* prefixIcon:
                  (ref.watch(selectedChatProvider) == null)
                      ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: context.primaryContainer,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<SupportedAgent>(
                              borderRadius: BorderRadius.circular(12),
                              value: selectedAgent.value,
                              hint: KText(
                                'Select your desired agent',
                                fontSize: 14,
                              ),
                              items:
                                  SupportedAgent.agents.map((e) {
                                    return DropdownMenuItem<SupportedAgent>(
                                      value: e,
                                      child: KText(e.name, fontSize: 14),
                                    );
                                  }).toList(),
                              onChanged: (SupportedAgent? value) {
                                if (value != null) {
                                  selectedAgent.value = value;
                                }
                              },
                            ),
                          ),
                        ),
                      )
                      : null,*/

              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  String query = chatTextController.text;
                  chatTextController.clear();
                  bool isNewChat = ref.read(chatHistoryProvider.notifier).newChat;

                  if (query.isNotEmpty) {
                    //animated the scroll to the bottom
                    //scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    scrollController.animateTo(
                      scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    isNewChat
                        ? await ref
                            .read(chatHistoryProvider.notifier)
                            .startChat(
                              query: query,
                              agentType:
                                  selectedAgent.value?.type.name ?? 'default',
                            )
                        : await ref
                            .read(chatHistoryProvider.notifier)
                            .continueChat(query: query);
                  }
                  /*print(
                                  ref
                                      .read(chatHistoryProvider.notifier)
                                      .isThinking,
                                );
                                ref
                                    .read(chatHistoryProvider.notifier)
                                    .updateThinkingState(true);
                                print(
                                  ref
                                      .watch(chatHistoryProvider.notifier)
                                      .isThinking,
                                );*/
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
