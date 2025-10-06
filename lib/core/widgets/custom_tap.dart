import 'package:flutter/material.dart';

class CustomTap extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const CustomTap({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
