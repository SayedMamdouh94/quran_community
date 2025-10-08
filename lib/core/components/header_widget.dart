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
    final screenSize = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Larger sizes for landscape mode
    final headerHeight = isLandscape ? 120.0 : 50.h;
    final textFontSize = isLandscape ? 12.0 : 5.sp;
    final surahNumberFontSize = isLandscape ? 40.0 : 22.sp;
    final horizontalPadding = isLandscape ? 40.0 : 15.7.w;
    final verticalPadding = isLandscape ? 20.0 : 7.h;

    return SizedBox(
      height: headerHeight,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/888-02.png",
              width: screenSize.width,
              height: headerHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "اياتها\n${getVerseCount(e["surah"])}",
                  style: TextStyle(
                      fontSize: textFontSize,
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
                          fontSize: surahNumberFontSize,
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                Text(
                  "ترتيبها\n${e["surah"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: textFontSize,
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
