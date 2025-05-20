import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/chat_tile.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatSessionList extends ConsumerWidget {
  final bool addTopSpacing;
  final bool isMobile;
  const ChatSessionList({super.key, this.addTopSpacing = true, this.isMobile=false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    final chatSession = ref.watch(getChatSessionFutureProvider(user.username));

    ref.listen<AsyncValue<List<ChatResModel>>>(
      getChatSessionFutureProvider(user.username),
      (previous, next) {
        if (next.value != null && previous?.value != null) {
          ChatResModel? newChat = next.value!.getNewChat(previous!.value!);
          if (newChat != null) {
            ref.read(selectedChatProvider.notifier).state = newChat;
          }
        }
      },
    );
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
         if(addTopSpacing) ColSpacing(16),
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
                ref.read(chatHistoryProvider.notifier).updateNewChatState(true);
                if (isMobile) {
                  //close Drawer
                  Scaffold.of(context).closeDrawer();
                }
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

              //sort list according to date
              data.sort((a, b) {
                return b.createdAt.compareTo(a.createdAt);
              });
              return ListView.separated(
                shrinkWrap: true,
                //reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatTile(chat: data[index],isMobile: isMobile,);
                },
                separatorBuilder: (context, index) {
                  return ColSpacing(2);
                },
                itemCount: data.length,
              );
            },
            error: (e, _) {
              return SizedBox(
                height: 500,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Unable to retrieve: $e'),
                      ColSpacing(24),
                      FilledButton.icon(
                        onPressed:
                            () async => await ref.refresh(
                              getChatSessionFutureProvider(user.username),
                            ),
                        icon: Icon(Icons.refresh),
                        label: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () {
              return Center(child: CircularProgressIndicator());
            },
          ),
          ColSpacing(56),
        ],
      ),
    );
  }
}
