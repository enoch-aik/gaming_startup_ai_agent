import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/supported_agent.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/ai_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_tile.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/human_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/thinking_message_bubble.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/extensions/string.dart';
import 'package:gaming_startup_ai_agent/src/res/styles/styles.dart';
import 'package:gaming_startup_ai_agent/src/widgets/init_icon.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    // final UserAuthInformation user = ;

    final searchTextController = useTextEditingController();
    final chatTextController = useTextEditingController();
    Size screenSize = MediaQuery.of(context).size;
    final chatRepo = ref.read(chatRepoProvider);
    final chatSession = ref.watch(getChatSessionFutureProvider(user.username));
    final selectedChat = ref.watch(selectedChatProvider);

    final ValueNotifier<SupportedAgent?> selectedAgent = useState(null);

    final chatHistory = ref.watch(chatHistoryProvider);

    //create a listener for chatsession so that once another chat session is added, it automatically updates the selectedChat to the new session

    ref.listen<AsyncValue<List<ChatResModel>>>(
      getChatSessionFutureProvider(user.username),
      (previous, next) {
        if (next.value != null) {
          ref.read(selectedChatProvider.notifier).state = next.value!.first;
        }
      },
    );

    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: screenSize.width * 0.225,
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
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ColSpacing(16),
                        Container(
                          height: 50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: context.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            onTap: () {
                              ref.read(selectedChatProvider.notifier).state =
                                  null;
                              ref
                                  .read(chatHistoryProvider.notifier)
                                  .clearChat();
                            },
                            leading: Icon(
                              Icons.add_comment_rounded,
                              color: context.primary,
                            ),
                            title: Text(
                              'Start new chat',
                              // style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        ColSpacing(16),
                        chatSession.when(
                          data: (data) {
                            /*if (data.isNotEmpty) {
                              ref.read(selectedChatProvider.notifier).state =
                                  data.first;
                            }*/

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ChatTile(chat: data[index]);
                              },
                              separatorBuilder: (context, index) {
                                return ColSpacing(2);
                              },
                              itemCount: data.length,
                            );
                          },
                          error: (e, _) {
                            return SizedBox(child: Text('Unable to retrieve'));
                          },
                          loading: () {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 4.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        titleAlignment: ListTileTitleAlignment.center,
                        leading: InitIcon(
                          text: user.username,
                          size: 40,
                          backgroundColor: context.primary,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                        ),
                        title: Text(user.username.capitalizeFirst),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16, right: 16),
              child: Stack(
                children: [
                  if (selectedChat != null)
                    chatHistory.when(
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
                                      return HumanMessageBubble(
                                        message: currentData,
                                      );
                                    case ChatType.human:
                                      return HumanMessageBubble(
                                        message: currentData,
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
                      error: (e, _) {
                        return Center(
                          child: Text(
                            'Unable to retrieve chat history: ${e.toString()}',
                          ),
                        );
                      },
                      loading: () {
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  Align(
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
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 4,
                            bottom: 4,
                          ),
                          hintText:
                              (selectedAgent.value) != null
                                  ? selectedAgent.value!.hintText
                                  : ref
                                      .read(chatHistoryProvider.notifier)
                                      .newChat
                                  ? 'Ask me anything related to games'
                                  : 'Type your message here',
                          hintStyle: AppStyles.textStyle.copyWith(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),

                          prefixIcon:
                              ref.read(chatHistoryProvider.notifier).newChat
                                  ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: context.primaryContainer,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<SupportedAgent>(
                                          value: selectedAgent.value,
                                          hint: KText(
                                            'Select your desired agent',
                                            fontSize: 14,
                                          ),
                                          items:
                                              SupportedAgent.agents.map((e) {
                                                return DropdownMenuItem<
                                                  SupportedAgent
                                                >(
                                                  value: e,
                                                  child: KText(
                                                    e.name,
                                                    fontSize: 14,
                                                  ),
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
                                  : null,

                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              String query = chatTextController.text;
                              chatTextController.clear();
                              bool isNewChat =
                                  ref
                                      .read(chatHistoryProvider.notifier)
                                      .newChat;

                              if (query.isNotEmpty) {
                                isNewChat
                                    ? await ref
                                        .read(chatHistoryProvider.notifier)
                                        .continueChat(query: query)
                                    : await ref
                                        .read(chatHistoryProvider.notifier)
                                        .startChat(
                                          query: query,
                                          agentType:
                                              selectedAgent.value?.type.name ??
                                              'default',
                                        );
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
