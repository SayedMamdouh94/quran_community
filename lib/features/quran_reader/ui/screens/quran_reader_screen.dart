import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../core/components/basmallah.dart';
import '../../../../core/components/header_widget.dart';
import '../../../../core/constants/app_constants.dart';

class QuranReaderScreen extends StatefulWidget {
  final int pageNumber;
  final dynamic jsonData;
  final bool shouldHighlightText;
  final String highlightVerse;

  const QuranReaderScreen({
    super.key,
    required this.pageNumber,
    required this.jsonData,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen>
    with AutomaticKeepAliveClientMixin {
  var highlightVerse;
  var shouldHighlightText;
  bool isDarkMode = false; // Add dark mode state
  bool showFrame = true; // Add frame toggle state
  Set<String> bookmarkedAyahs = {}; // Store permanently colored ayahs
  List<GlobalKey> richTextKeys = List.generate(
    604, // Replace with the number of pages in your PageView
    (_) => GlobalKey(),
  );

  // Performance optimization: Cache page data and verse text
  final Map<int, List<dynamic>> _pageDataCache = {};
  final Map<String, String> _verseTextCache = {};
  bool _isInitialLoad = true;

  @override
  bool get wantKeepAlive => true;

  setIndex() {
    setState(() {
      index = widget.pageNumber;
    });
  }

  // Load bookmarked ayahs from storage
  Future<void> loadBookmarkedAyahs() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_ayahs') ?? [];
    setState(() {
      bookmarkedAyahs = bookmarks.toSet();
    });
  }

  // Save bookmarked ayahs to storage
  Future<void> saveBookmarkedAyahs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bookmarked_ayahs', bookmarkedAyahs.toList());
  }

  // Toggle bookmark for an ayah
  void toggleBookmark(String ayahId) {
    setState(() {
      if (bookmarkedAyahs.contains(ayahId)) {
        bookmarkedAyahs.remove(ayahId);
      } else {
        bookmarkedAyahs.add(ayahId);
      }
    });
    saveBookmarkedAyahs();
  }

  int index = 0;
  late PageController _pageController;
  late Timer timer;
  String selectedSpan = "";
  String highlightedAyah = ""; // Add highlighted ayah tracking

  // Get cached page data
  List<dynamic> getCachedPageData(int pageIndex) {
    if (!_pageDataCache.containsKey(pageIndex)) {
      _pageDataCache[pageIndex] = getPageData(pageIndex);
    }
    return _pageDataCache[pageIndex]!;
  }

  // Get cached verse text
  String getCachedVerseText(int surah, int verse) {
    final key = "${surah}_$verse";
    if (!_verseTextCache.containsKey(key)) {
      _verseTextCache[key] = getVerseQCF(surah, verse).replaceAll(' ', '');
    }
    return _verseTextCache[key]!;
  }

  highlightVerseFunction() {
    setState(() {
      shouldHighlightText = widget.shouldHighlightText;
    });
    if (widget.shouldHighlightText) {
      setState(() {
        highlightVerse = widget.highlightVerse;
      });

      Timer.periodic(const Duration(milliseconds: 400), (timer) {
        if (mounted) {
          setState(() {
            shouldHighlightText = false;
          });
        }
        Timer(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              shouldHighlightText = true;
            });
          }
          if (timer.tick == 4) {
            if (mounted) {
              setState(() {
                highlightVerse = "";
                shouldHighlightText = false;
              });
            }
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  void initState() {
    setIndex();
    _pageController = PageController(initialPage: index);
    highlightVerseFunction();
    loadBookmarkedAyahs(); // Load saved bookmarks
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WakelockPlus.enable();
    super.initState();

    // Mark initial load complete after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isInitialLoad = false;
        });
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Must call super for AutomaticKeepAliveClientMixin
    final screenSize = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = screenSize.shortestSide >=
        600; // Detect tablets (iPad, Android tablets)

    // Calculate device size categories for responsive scaling
    // 720x1280 physical pixels = ~360 logical pixels (at 2.0 density)
    final screenWidth = screenSize.width;

    final isSmallDevice =
        screenWidth <= 360; // Small devices like 720x1280px screens
    final isMidDevice =
        screenWidth > 360 && screenWidth <= 415; // Pixel 9a (~411px)
    final isVeryLargeDevice =
        screenWidth > 450; // Very large phones and tablets
    // Pixel 8 Pro falls into the 415-450 range (not small, not mid, not very large)

    return Scaffold(
      body: PageView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        allowImplicitScrolling: true, // Pre-cache adjacent pages
        onPageChanged: (i) {
          setState(() {
            selectedSpan = "";
            highlightedAyah = ""; // Clear highlight when page changes
          });
          index = i;
        },
        controller: _pageController,
        itemCount: 605, // 604 pages + 1 cover page
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: const Color(0xffFFFCE7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(QuranConstants.largePadding * 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius:
                          BorderRadius.circular(QuranConstants.borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: QuranColors.primary.withValues(alpha: 0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(QuranConstants.largePadding),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.book_rounded,
                          size: 80,
                          color: QuranColors.primary,
                        ),
                        const SizedBox(height: QuranConstants.defaultPadding),
                        const Text(
                          "القرآن الكريم",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: QuranColors.textPrimary,
                            fontFamily: "Taha",
                          ),
                        ),
                        const SizedBox(height: QuranConstants.smallPadding),
                        Text(
                          "﴿وَنُنَزِّلُ مِنَ الْقُرْآنِ مَا هُوَ شِفَاءٌ وَرَحْمَةٌ لِّلْمُؤْمِنِينَ﴾",
                          style: QuranTextStyles.verseText.copyWith(
                            fontSize: 18,
                            color: QuranColors.primary,
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: QuranConstants.defaultPadding),
                        const Text(
                          "اسحب يميناً للبدء",
                          style: TextStyle(
                            fontSize: 16,
                            color: QuranColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // Show loading indicator for initial page load
          if (_isInitialLoad && index == widget.pageNumber) {
            return Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: QuranColors.primary,
                ),
              ),
            );
          }

          return Container(
            color: isDarkMode ? Colors.black : Colors.white,
            child: Column(
              children: [
                // Header outside the frame
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0.w,
                    vertical: 4.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button and surah name
                      SizedBox(
                        width: screenSize.width * (isTablet ? 0.33 : 0.27),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 24,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                )),
                            Text(
                                widget.jsonData[getCachedPageData(index)[0]
                                        ["surah"] -
                                    1]["name"],
                                style: TextStyle(
                                    fontFamily: "Taha",
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black)),
                          ],
                        ),
                      ),
                      // Page number
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isDarkMode
                              ? Colors.grey[800]?.withOpacity(.7)
                              : QuranColors.primaryLight.withValues(alpha: 0.7),
                          border: Border.all(
                              color:
                                  isDarkMode ? Colors.grey[600]! : Colors.grey),
                        ),
                        height: 20.h,
                        width: 120.w,
                        child: Center(
                          child: Text(
                            "صفحة $index",
                            style: TextStyle(
                              fontFamily: 'aldahabi',
                              fontSize: 12,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // Frame and theme toggle buttons
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Hide frame button in landscape mode
                            if (!isLandscape)
                              IconButton(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showFrame = !showFrame;
                                    });
                                  },
                                  icon: Icon(
                                    showFrame
                                        ? Icons.border_outer
                                        : Icons.border_clear,
                                    size: 20,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            IconButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isDarkMode = !isDarkMode;
                                  });
                                },
                                icon: Icon(
                                  isDarkMode
                                      ? Icons.light_mode
                                      : Icons.dark_mode,
                                  size: 20,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Frame and Content
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Background SVG Frame - conditionally shown (hidden in landscape)
                      if (showFrame && !isLandscape)
                        Positioned(
                          top: isSmallDevice ? 5 : (isMidDevice ? 35.h : 30.h),
                          left: 5,
                          right: 5,
                          bottom: isMidDevice
                              ? 55
                              : isVeryLargeDevice
                                  ? 40
                                  : (isSmallDevice
                                      ? 10.h
                                      : 40.h), // Reduce frame height to match text
                          child: Transform.scale(
                            scale: isTablet
                                ? 0.98
                                : (isSmallDevice
                                    ? 1
                                    : (isMidDevice
                                        ? 0.97.r // Larger frame for Pixel 9a
                                        : (isVeryLargeDevice ? 0.96 : 0.90.r))),
                            child: SvgPicture.asset(
                              isDarkMode
                                  ? 'assets/svgs/darkframe.svg'
                                  : 'assets/svgs/newBorder.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      // Text content - scaled down to fit inside frame borders
                      Transform.scale(
                        scale: isLandscape
                            ? 1.0
                            : (showFrame
                                ? (isTablet
                                    ? 0.88
                                    : (isSmallDevice
                                        ? 0.88
                                        : (isMidDevice
                                            ? 0.87
                                                .r // Increased text scale for Pixel 9a
                                            : (isVeryLargeDevice
                                                ? 0.86
                                                : 0.80.r))))
                                : (isSmallDevice
                                    ? 0.95
                                    : 1.0)), // Reduce scale for small devices even without frame
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          floatingActionButton: highlightedAyah.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: QuranColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.bookmark,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "آية ${highlightedAyah.split('_')[1]} - سورة ${highlightedAyah.split('_')[0]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            highlightedAyah = "";
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : null,

                          body: SingleChildScrollView(
                            physics: isSmallDevice
                                ? const NeverScrollableScrollPhysics() // Disable scrolling on small devices
                                : const ClampingScrollPhysics(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, left: 12),
                              child: Column(
                                children: [
                                  if ((index == 1 || index == 2))
                                    SizedBox(
                                      height: (screenSize.height * .15),
                                    ),
                                  SizedBox(
                                    height: isTablet
                                        ? 15.h
                                        : (isSmallDevice
                                            ? 0 // No extra padding for small devices
                                            : (isMidDevice
                                                ? 25.h // Pixel 9a only
                                                : (isVeryLargeDevice
                                                    ? 5.h // Very large devices
                                                    : 30.h))), // Pixel 8 Pro (405-450px range)
                                  ),
                                  Transform.translate(
                                    offset: isSmallDevice
                                        ? Offset(0,
                                            -5.h) // Move text up for small devices
                                        : Offset.zero,
                                    child: Directionality(
                                        textDirection: m.TextDirection.rtl,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: RichText(
                                              key: richTextKeys[index - 1],
                                              textDirection:
                                                  m.TextDirection.rtl,
                                              textAlign: (index == 1 ||
                                                      index == 2 ||
                                                      index > 570)
                                                  ? TextAlign.center
                                                  : TextAlign.center,
                                              softWrap: true,
                                              locale: const Locale("ar"),
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : m.Colors.black,
                                                  fontSize: 23.sp.toDouble(),
                                                ),
                                                children:
                                                    getCachedPageData(index)
                                                        .expand((e) {
                                                  List<InlineSpan> spans = [];
                                                  for (var i = e["start"];
                                                      i <= e["end"];
                                                      i++) {
                                                    // Header
                                                    if (i == 1) {
                                                      spans.add(WidgetSpan(
                                                        child: HeaderWidget(
                                                            e: e,
                                                            jsonData:
                                                                widget.jsonData,
                                                            isDarkMode:
                                                                isDarkMode),
                                                      ));
                                                      if (index != 187 &&
                                                          index != 1) {
                                                        spans.add(WidgetSpan(
                                                          child: Basmallah(
                                                              index: 0,
                                                              isDarkMode:
                                                                  isDarkMode),
                                                        ));
                                                      }
                                                      if (index == 187) {
                                                        spans.add(WidgetSpan(
                                                          child: Container(
                                                            height: 10.h,
                                                          ),
                                                        ));
                                                      }
                                                    }

                                                    // Verses
                                                    final ayahId =
                                                        "${e["surah"]}_$i";
                                                    spans.add(TextSpan(
                                                      recognizer:
                                                          LongPressGestureRecognizer()
                                                            ..onLongPress = () {
                                                              // Add haptic feedback for long press
                                                              HapticFeedback
                                                                  .mediumImpact();

                                                              // Toggle bookmark
                                                              toggleBookmark(
                                                                  ayahId);
                                                            },
                                                      text: i == e["start"]
                                                          ? "${getCachedVerseText(e["surah"], i).substring(0, 1)}\u200A${getCachedVerseText(e["surah"], i).substring(1)}"
                                                          : getCachedVerseText(
                                                              e["surah"], i),
                                                      style: TextStyle(
                                                        color: bookmarkedAyahs
                                                                .contains(
                                                                    ayahId)
                                                            ? QuranColors
                                                                .primary
                                                            : (isDarkMode
                                                                ? Colors.white
                                                                : Colors.black),
                                                        height: (index == 1 ||
                                                                index == 2)
                                                            ? (isTablet
                                                                ? (isLandscape
                                                                    ? 1.5.h
                                                                    : 1.h)
                                                                : isSmallDevice
                                                                    ? (isLandscape
                                                                        ? 2.7.h
                                                                        : 2
                                                                            .h) // Reduced from 2.0.h
                                                                    : isMidDevice
                                                                        ? (isLandscape
                                                                            ? 2.5
                                                                                .h
                                                                            : 1.9
                                                                                .h) // Pixel 9a - larger line height
                                                                        : (isLandscape
                                                                            ? 2.5
                                                                                .h
                                                                            : 1.8
                                                                                .h))
                                                            : (isTablet
                                                                ? (isLandscape
                                                                    ? 1.6.h
                                                                    : 1.h)
                                                                : isSmallDevice
                                                                    ? (isLandscape
                                                                        ? 3.0.h
                                                                        : 2.5
                                                                            .h) // Reduced from 2.5.h
                                                                    : isMidDevice
                                                                        ? (isLandscape
                                                                            ? 2.8
                                                                                .h
                                                                            : 1.9
                                                                                .h) // Pixel 9a - larger line height for regular pages
                                                                        : (isLandscape
                                                                            ? 2.8.h
                                                                            : 1.75.h)),
                                                        letterSpacing: 0.0,
                                                        wordSpacing: 0,
                                                        fontFamily:
                                                            "QCF_P${index.toString().padLeft(3, "0")}",
                                                        fontSize: isTablet
                                                            ? (isLandscape
                                                                ? 23.7.sp
                                                                // Tablet landscape
                                                                : (index == 1 ||
                                                                        index ==
                                                                            2
                                                                    ? 28.5.sp
                                                                    : 23.5.sp))
                                                            : isMidDevice
                                                                ? (index == 1 ||
                                                                        index ==
                                                                            2
                                                                    ? 28.5.sp
                                                                    : isLandscape
                                                                        ? 24.sp
                                                                        : 23
                                                                            .sp) // Larger text for Pixel 9a
                                                                : (index == 1 ||
                                                                        index ==
                                                                            2
                                                                    ? 28.5.sp
                                                                    : index == 145 ||
                                                                            index ==
                                                                                201
                                                                        ? index == 532 ||
                                                                                index == 533
                                                                            ? 22.5.sp
                                                                            : 22.4.sp
                                                                        : isLandscape
                                                                            ? 24.sp
                                                                            : 23.1.sp),
                                                      ),
                                                    ));
                                                  }
                                                  return spans;
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ), // Close Transform.translate
                                ],
                              ), // Close Column
                            ), // Close Padding
                          ), // Close SingleChildScrollView (Scaffold body)
                        ), // Close Scaffold
                      ), // Close Transform.scale
                    ], // Close Stack children
                  ), // Close Stack
                ), // Close Expanded
              ], // Close Column children
            ), // Close Column
          ); // Close Container
        },
      ),
    );
  }
}
