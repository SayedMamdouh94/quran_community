import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Basmallah extends StatefulWidget {
  final int index;
  final bool isDarkMode;
  const Basmallah({super.key, required this.index, this.isDarkMode = false});

  @override
  State<Basmallah> createState() => _BasmallahState();
}

class _BasmallahState extends State<Basmallah> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: (screenSize.width * .2.h),
            right: (screenSize.width * .2.h),
            top: 0,
            bottom: 0.h),
        child: Image.asset(
          "assets/images/Basmala.png",
          color: widget.isDarkMode ? Colors.white : Colors.black,
          width: MediaQuery.of(context).size.width * .4,
        ),
      ),
    );
  }
}
