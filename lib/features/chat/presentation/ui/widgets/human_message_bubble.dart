import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';

class HumanMessageBubble extends StatelessWidget {
  final MessageResModel message;

  const HumanMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(
          minWidth: 200,
          maxWidth: screenSize.width * 0.4,
        ),
        decoration: BoxDecoration(
          color: context.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message.content),
      ),
    );
  }
}
