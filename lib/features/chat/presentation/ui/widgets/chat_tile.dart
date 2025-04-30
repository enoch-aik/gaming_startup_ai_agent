import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/widgets/text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatTile extends ConsumerWidget {
  final ChatResModel chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(selectedChatProvider) == chat;

    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: context.primary,
        //tileColor: context.secondary,
        key: ValueKey(chat.rawData),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(
          Icons.notes_rounded,
          color: isSelected ? context.onPrimary : context.onSecondary,
        ),
        title: KText(
          chat.sessionId,
          overflow: TextOverflow.ellipsis,
          color: isSelected ? context.onPrimary : context.onSecondary,
        ),
        onTap: () async {
          ref.read(chatHistoryProvider.notifier).updateNewChatState(false);

          bool hasPreviouslySelectedAnotherChat =
              ref.read(selectedChatProvider.notifier).state != null;
          // Check if the selected chat is different from the current one

          bool isDifferentChat =
              ref.read(selectedChatProvider.notifier).state != chat;

          ref.read(selectedChatProvider.notifier).state = chat;

          print('Selected chat: ${ref.watch(selectedChatProvider)}');
          /*if (hasPreviouslySelectedAnotherChat || isDifferentChat) {
            ref.invalidate(chatHistoryProvider);
          }*/

          return await ref.refresh(chatHistoryProvider.future);
        },
      ),
    );
  }
}
