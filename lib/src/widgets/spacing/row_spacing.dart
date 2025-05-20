import 'package:flutter/material.dart';

class RowSpacing extends StatelessWidget {
  final double width;

  const RowSpacing({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
