import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';

class HeaderWidget extends StatelessWidget {
  final dynamic e;
  final dynamic jsonData;
  final bool isDarkMode;

  const HeaderWidget({
    super.key,
    required this.e,
    required this.jsonData,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/888-02.png",
              width: MediaQuery.of(context).size.width,
              height: 50.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.7.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "اياتها\n${getVerseCount(e["surah"])}",
                  style: TextStyle(
                      fontSize: 5.sp,
                      fontFamily: "UthmanicHafs13",
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: e["surah"].toString(),

                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "arsura",
                          fontSize: 22.sp,
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                Text(
                  "ترتيبها\n${e["surah"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 5.sp,
                      fontFamily: "UthmanicHafs13",
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
