import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/ui/widgets/ai_message_bubble.dart';
import 'package:gaming_startup_ai_agent/src/constants/prompt.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';

class HumanMessageBubble extends StatelessWidget {
  final MessageResModel message;

  const HumanMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return message.content ==(technicalPrototypePrompt)
        ? SizedBox()
        : Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(
                  minWidth: 70,
                  maxWidth: screenSize.width * 0.4,
                ),
                decoration: BoxDecoration(
                  color: context.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectionArea(child: Text(message.content)),
              ),
              ColSpacing(4),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    //padding: EdgeInsets.zero,
                    splashFactory:  NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    //color: context.primaryContainer,
                    onTap: () {
                      try {
                        Clipboard.setData(
                          ClipboardData(
                            text:
                            removeMarkdownLinks(
                              message.content,
                            ).trim(),
                          ),
                        ).then((_) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Copied to clipboard'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        });
                      } catch (_) {}
                    },
                    child: SvgPicture.asset('assets/svg/copy_outlined.svg',
                    color: context.primaryContainer,
                    width: 16,),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
