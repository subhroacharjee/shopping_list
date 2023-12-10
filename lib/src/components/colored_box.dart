import 'package:flutter/material.dart';

class TColoredBox extends StatelessWidget {
  TColoredBox({required this.color, this.size = 20});
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: size,
      width: size,
      child: const Padding(padding: EdgeInsets.all(20)),
    );
  }
}
