import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_tutorial/core/constants/app_constants.dart';


class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color textColor;
  final Widget? child;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    this.text,
    this.textColor = QuranColors.primary,
    this.child,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(
          textColor.withValues(alpha: 0.1),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      child: child ??
          Text(
            text ?? '',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? 16.0.sp,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
            textAlign: textAlign,
          ),
    );
  }
}
