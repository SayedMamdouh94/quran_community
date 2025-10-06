import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SpacingEx on num {
  SizedBox get hSpace => SizedBox(height: h.toDouble());

  SizedBox get wSpace => SizedBox(width: w.toDouble());
}

extension FormatDuration on Duration {
  String get format =>
      toString().split('.').first.padLeft(8, "0").substring(3, 8);
}
