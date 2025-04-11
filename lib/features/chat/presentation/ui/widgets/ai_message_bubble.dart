import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiMessageBubble extends ConsumerWidget {
  final MessageResModel? message;
  final bool isThinking;

  const AiMessageBubble({
    super.key,
    required this.message,
    required this.isThinking,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomLeft,
      child:
           ConstrainedBox(
             constraints: BoxConstraints(
             minWidth: 200,
             maxWidth: screenSize.width * 0.65,
           ),
             child: GptMarkdownTheme(
                  gptThemeData: GptMarkdownTheme.of(context),
                  child: GptMarkdown(message!.content),
                ),
           )
      ,
    );
  }
}
