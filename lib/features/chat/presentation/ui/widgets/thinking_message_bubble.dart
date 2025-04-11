import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/row_spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiThinkingMessageBubble extends ConsumerWidget {
  const AiThinkingMessageBubble({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isThinking = ref.watch(chatHistoryProvider.notifier).thinking;
    return Align(
      alignment: Alignment.centerLeft,
      child: isThinking ? Row(
        mainAxisSize: MainAxisSize.min,
        
        children: [
         CupertinoActivityIndicator(),
          RowSpacing(width: 8),
          Text('Thinking...')
        ],
      ) : SizedBox(),
    );
  }
}
