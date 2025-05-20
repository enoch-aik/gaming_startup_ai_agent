import 'package:flutter/material.dart';

Future<dynamic> showAnimatedDialog(
  BuildContext context,
  Widget dialog, {
  bool isFlip = false,
  bool isDismissible = true,
}) async => showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, animation1, animation2) => dialog,
    transitionDuration: const Duration(milliseconds: 1000),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: widget,
        ),
      );
    },
  );
