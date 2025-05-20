import 'package:flutter/material.dart';

class ColSpacing extends StatelessWidget {
  final double height;

  const ColSpacing(this.height,{super.key,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
