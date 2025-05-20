/*
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomImageRenderer extends StatelessWidget {
  final String url;

  const CustomImageRenderer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int _) => ImageElement()..src = url,
    );
    return HtmlElementView(viewType: url);
  }
}
*/
