import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../home/ui/screens/home_screen.dart';

class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({super.key});

  @override
  State<LoadingSplashScreen> createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen>
    with SingleTickerProviderStateMixin {
  dynamic jsonData;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create animations
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Start the animation
    _animationController.forward();

    // Load data and navigate
    _init();
  }

  Future<void> _init() async {
    try {
      await _loadJsonData();

      // Wait for animation to complete
      await Future.delayed(const Duration(milliseconds: 2000));

      // Navigate to main screen
      _navigateToMain();
    } catch (e) {
      // Fallback navigation in case of error
      await Future.delayed(const Duration(milliseconds: 2000));
      _navigateToMain();
    }
  }

  Future<void> _loadJsonData() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    jsonData = jsonDecode(jsonString);
  }

  void _navigateToMain() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuranLightColors.background,
      body: Container(
        decoration: const BoxDecoration(
          color: QuranLightColors.background,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(QuranConstants.largePadding),
                    decoration: BoxDecoration(
                      color: QuranLightColors.surface,
                      borderRadius: BorderRadius.circular(
                          QuranConstants.borderRadius * 2),
                      boxShadow: [
                        BoxShadow(
                          color: QuranLightColors.primary.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: QuranConstants.largePadding * 2),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    const Text(
                      "القرآن الكريم",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: QuranLightColors.primary,
                        fontFamily: "Taha",
                      ),
                    ),
                    const SizedBox(height: QuranConstants.smallPadding),
                    Text(
                      "بسم الله الرحمن الرحيم",
                      style: QuranTextStyles.verseText.copyWith(
                        fontSize: 16,
                        color: QuranLightColors.textSecondary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
