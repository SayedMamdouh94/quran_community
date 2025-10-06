import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../quran/ui/screens/quran_sura_screen.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/home_welcome_widget.dart';
import '../widgets/home_navigation_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _suraJsonData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJsonAsset();
  }

  Future<void> _loadJsonAsset() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/surahs.json');
      final data = jsonDecode(jsonString);
      setState(() {
        _suraJsonData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
      debugPrint('Error loading JSON: $e');
    }
  }

  void _navigateToQuranPage() {
    if (_suraJsonData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuranSuraScreen(suraJsonData: _suraJsonData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuranColors.background,
      appBar: const HomeAppBarWidget(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: QuranColors.primary,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: QuranConstants.largePadding),
                  
                  // Welcome Section
                  const HomeWelcomeWidget(),
                  
                  const SizedBox(height: QuranConstants.largePadding * 2),
                  
                  // Navigation Buttons
                  HomeNavigationButtonWidget(
                    title: "تصفح سور القرآن",
                    icon: Icons.list_rounded,
                    onPressed: _navigateToQuranPage,
                  ),
                  
                  const SizedBox(height: QuranConstants.defaultPadding),
                  
                  HomeNavigationButtonWidget(
                    title: "المصحف كاملاً",
                    icon: Icons.menu_book_rounded,
                    onPressed: () {
                      // TODO: Implement full Quran reading
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('قريباً إن شاء الله'),
                        ),
                      );
                    },
                    backgroundColor: QuranColors.primaryLight,
                  ),
                  
                  const SizedBox(height: QuranConstants.defaultPadding),
                  
                  HomeNavigationButtonWidget(
                    title: "البحث في القرآن",
                    icon: Icons.search_rounded,
                    onPressed: () {
                      // TODO: Implement search functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('متوفر في صفحة السور'),
                        ),
                      );
                    },
                    backgroundColor: QuranColors.textSecondary,
                  ),
                  
                  const SizedBox(height: QuranConstants.largePadding * 3),
                  
                  // Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: QuranConstants.defaultPadding,
                    ),
                    child: Text(
                      "﴿وَنُنَزِّلُ مِنَ الْقُرْآنِ مَا هُوَ شِفَاءٌ وَرَحْمَةٌ لِّلْمُؤْمِنِينَ﴾",
                      style: QuranTextStyles.verseText.copyWith(
                        fontSize: 18,
                        color: QuranColors.primary,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  
                  const SizedBox(height: QuranConstants.largePadding),
                ],
              ),
            ),
    );
  }
}