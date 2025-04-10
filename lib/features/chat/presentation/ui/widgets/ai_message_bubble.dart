import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class AiMessageBubble extends StatelessWidget {
  final MessageResModel message;

  const AiMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: GptMarkdownTheme(
        gptThemeData: GptMarkdownTheme.of(context),
        child: GptMarkdown(message.content),
      ),
    );
  }
}
