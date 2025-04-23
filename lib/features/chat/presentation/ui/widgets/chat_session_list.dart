import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_tile.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatSessionList extends ConsumerWidget {
  const ChatSessionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    final chatSession = ref.watch(getChatSessionFutureProvider(user.username));

    return Padding(
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
                ref.read(selectedChatProvider.notifier).state = null;
                ref.read(chatHistoryProvider.notifier).clearChat();
              },
              leading: Icon(Icons.add_comment_rounded, color: context.primary),
              title: Text(
                'Start new chat',
                // style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          ColSpacing(16),
          chatSession.when(
            data: (data) {
              /* if (data.isNotEmpty) {
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
    );
  }
}
