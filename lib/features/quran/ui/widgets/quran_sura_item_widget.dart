import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../quran_reader/ui/screens/quran_reader_screen.dart';

class QuranSuraItemWidget extends StatelessWidget {
  final dynamic suraData;
  final int index;
  final dynamic suraJsonData;

  const QuranSuraItemWidget({
    super.key,
    required this.suraData,
    required this.index,
    required this.suraJsonData,
  });

  @override
  Widget build(BuildContext context) {
    int suraNumber = index + 1;
    String suraName = suraData["englishName"];
    String suraNameEnglishTranslated = suraData["englishNameTranslation"];
    int suraNumberInQuran = suraData["number"];
    int ayahCount = getVerseCount(suraNumber);

    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: QuranConstants.defaultPadding),
      decoration: BoxDecoration(
        color: QuranLightColors.surface,
        borderRadius: BorderRadius.circular(QuranConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(QuranConstants.borderRadius),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => QuranReaderScreen(
                  shouldHighlightText: false,
                  highlightVerse: "",
                  jsonData: suraJsonData,
                  pageNumber: getPageNumber(suraNumberInQuran, 1),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(QuranConstants.largePadding),
            child: Row(
              children: [
                // Sura Number Circle
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: QuranLightColors.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: QuranLightColors.primary.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      suraNumber.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: QuranConstants.defaultPadding),
                // Sura Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suraName,
                        style: QuranTextStyles.suraTitle,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              suraNameEnglishTranslated,
                              style: QuranTextStyles.suraSubtitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: QuranConstants.smallPadding),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: QuranConstants.smallPadding,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: QuranLightColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  QuranConstants.cardBorderRadius),
                            ),
                            child: Text(
                              "$ayahCount آية",
                              style: const TextStyle(
                                fontSize: 12,
                                color: QuranLightColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Arabic Sura Number and Arrow
                Column(
                  children: [
                    Text(
                      suraNumber.toString(),
                      style: QuranTextStyles.arabicNumber,
                    ),
                    const SizedBox(height: QuranConstants.smallPadding),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: QuranLightColors.textSecondary.withOpacity(0.5),
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
