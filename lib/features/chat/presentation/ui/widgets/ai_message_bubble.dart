import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AiMessageBubble extends ConsumerStatefulWidget {
  final MessageResModel? message;
  final bool isThinking;
  final bool isLast;

  AiMessageBubble({
    super.key,
    required this.message,
    required this.isThinking,
    this.isLast = false,
  });

  @override
  ConsumerState<AiMessageBubble> createState() => _AiMessageBubbleState();
}

class _AiMessageBubbleState extends ConsumerState<AiMessageBubble> {
  String displayedText = '';

  //late Timer? _timer;

  @override
  void initState() {
    super.initState();

    /* if ((widget.message?.shouldAnimate ?? false) && widget.isLast) {
      _startAnimation();
    }*/
  }

  /*void _startAnimation() {
    int index = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (index < widget.message!.content.length) {
        setState(() {
          displayedText += widget.message!.content[index];
        });
        index++;
      } else {
        timer.cancel();
      }
    });
  }*/

  @override
  void dispose() {
    /*if (_timer != null && (_timer?.isActive ?? false)) {
      _timer?.cancel();
    }*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isWeb = kIsWeb;
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 200,
          maxWidth: screenSize.width * 0.57,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GptMarkdownTheme(
              gptThemeData: GptMarkdownTheme.of(context),
              child: SelectionArea(
                child: GptMarkdown(
                  ((widget.message?.shouldAnimate ?? false) && widget.isLast)
                      ? displayedText
                      : widget.message!.content,
                  textAlign: TextAlign.justify,
                  imageBuilder: (context, url) {
                    bool isImg =
                        url.endsWith('.png') ||
                        url.endsWith('.jpg') ||
                        url.endsWith('.jpeg') ||
                        url.endsWith('.webp');

                    return isImg
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Stack(
                            children: [
                              //Image.network(url, width: 400, height: 400),
                              FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: url,
                                width: 400,
                                height: 400,
                                filterQuality: FilterQuality.low,
                                imageErrorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                                  return SizedBox(
                                    height: 400,
                                    width: 400,
                                    child: CupertinoActivityIndicator(),
                                  ); //do something
                                },
                              ),
                              /*Positioned(
                                bottom: 8,
                                right: 8,
                                child: IconButton(
                                  onPressed: () async {
                                    if (isWeb) {
                                      String fileName = url.split('/').last;
                                    File imageFile =  await ImageUtils.imageToFile(url: url);
                                    await FileSaver.instance.saveFile(
                                      name: fileName,
                                      file: imageFile,
                                      ext: 'png',
                                    );
                                    }
                                  },
                                  color: context.primaryContainer,
                                  iconSize: 32,
                                  icon: Icon(Icons.download_for_offline_sharp),
                                ),
                              ),*/
                            ],
                          ),
                        )
                        : Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Preview link',
                                style: TextStyle(color: Colors.blue),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (await canLaunchUrl(
                                          Uri.parse(url),
                                        )) {
                                          launchUrl(Uri.parse(url));
                                        }
                                      },
                              ),
                            ],
                          ),
                        );
                  },
                  onLinkTab: (url, title) async {
                    Uri uri = Uri.parse(url);
                    await _launchUrl(uri);
                  },
                ),
              ),
            ),
            ColSpacing(4),
            Row(
              children: [
                InkWell(
                  // padding: EdgeInsets.zero,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashFactory:  NoSplash.splashFactory,
                  //iconSize: 14,
                  //color: context.primaryContainer,
                  onTap: () {
                    try {
                      Clipboard.setData(
                        ClipboardData(
                          text:
                              removeMarkdownLinks(
                                widget.message!.content,
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
                  child: SvgPicture.asset(
                    'assets/svg/copy_outlined.svg',
                    color: context.primaryContainer,
                    width: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

class ImageUtils {
  static Future<File> imageToFile({required String url}) async {
    final response = await HttpClient().getUrl(Uri.parse(url));
    final bytes = await response.close().then(
      (response) => response.fold(
        <int>[],
        (List<int> bytes, List<int> chunk) => bytes..addAll(chunk),
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/image.png');
    await file.writeAsBytes(bytes);

    return file;
  }
}

String removeMarkdownLinks(String text) {
  final RegExp linkRegex = RegExp(
    r'!?\[([^\]]+)\]\([^)]+\)',
    caseSensitive: false,
  );
  return text.replaceAllMapped(linkRegex, (match) {
    // Return only the text inside the brackets
    return match.group(0)!.startsWith('!') ? '' : match.group(1) ?? '';
  });
}
