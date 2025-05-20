

import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/src/widgets/text.dart';

Future showMessageAlertDialog(
  context, {
  required text,
  onTap,
  isDismissible,
  String? actionText,
      double? width,
}) {
  return showDialog(
    barrierDismissible: isDismissible ?? true,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      content: KText(text, textAlign: TextAlign.center, fontSize: 16),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: SizedBox(
            height: 40,
            width:width?? double.maxFinite,
            child: FilledButton(
              onPressed: onTap ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: Text(actionText ?? 'Got it'),
            ),
          ),
        ),
      ],
    ),
  );
}
