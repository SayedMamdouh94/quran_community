import 'package:flutter/material.dart';
import 'package:quran_tutorial/core/helpers/extensions/context_extenstions.dart';
import 'package:quran_tutorial/core/widgets/custom_text.dart';


class TapTile extends StatefulWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  const TapTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  State<TapTile> createState() => _TapTileState();
}

class _TapTileState extends State<TapTile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TapTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      borderRadius: BorderRadius.circular(8),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? context.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: widget.isSelected
                      ? [
                          BoxShadow(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.2,
                            ),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: CustomText(
                  widget.title,
                  style: context.textTheme.bodyLarge,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: widget.isSelected
                      ? Colors.white
                      : context.colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
