import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class HomeNavigationButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const HomeNavigationButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: QuranConstants.defaultPadding),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: textColor ?? Colors.white,
          size: 24,
        ),
        label: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? QuranColors.primary,
          padding: const EdgeInsets.symmetric(
            vertical: QuranConstants.defaultPadding,
            horizontal: QuranConstants.largePadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QuranConstants.borderRadius),
          ),
          elevation: 4,
          shadowColor: (backgroundColor ?? QuranColors.primary).withOpacity(0.3),
        ),
      ),
    );
  }
}