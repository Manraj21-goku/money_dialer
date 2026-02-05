import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_project/core/theme/app_theme.dart';
import 'package:new_project/shared/widgets/buttons/primary_button.dart';

/// An animated stack that transitions between pages with slide and fade effects
class AnimatedStack extends StatefulWidget {
  final List<Widget> pages;
  final List<String> ctaLabels;
  final bool allowCycle;
  final ValueChanged<int>? onPageChanged;

  const AnimatedStack({
    super.key,
    required this.pages,
    required this.ctaLabels,
    this.allowCycle = false,
    this.onPageChanged,
  }) : assert(pages.length == ctaLabels.length, 'Pages and CTA labels must have same length');

  @override
  State<AnimatedStack> createState() => _AnimatedStackState();
}

class _AnimatedStackState extends State<AnimatedStack> with TickerProviderStateMixin {
  int _currentIndex = 0;
  Widget? _previousPage;
  bool _isAnimating = false;

  late final AnimationController _slideController;
  late final AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _slideController = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: AppDurations.slow,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = _createSlideAnimation(const Offset(0, 1));

    _slideController.addStatusListener(_handleAnimationStatus);
  }

  Animation<Offset> _createSlideAnimation(Offset begin) {
    return Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
  }

  void _handleAnimationStatus(AnimationStatus status) {
    setState(() {
      _isAnimating = status == AnimationStatus.forward;
    });
  }

  void _goToNextPage() {
    if (_isAnimating) return;
    
    final canAdvance = widget.allowCycle || _currentIndex < widget.pages.length - 1;
    if (!canAdvance) return;

    _slideAnimation = _createSlideAnimation(const Offset(0, 1));

    setState(() {
      _previousPage = widget.pages[_currentIndex];
      _currentIndex = widget.allowCycle 
          ? (_currentIndex + 1) % widget.pages.length
          : _currentIndex + 1;
    });

    _slideController.forward(from: 0);
    _fadeController.forward(from: 0);
    widget.onPageChanged?.call(_currentIndex);
  }

  void _goToPreviousPage() {
    if (_isAnimating || _currentIndex == 0) return;

    setState(() {
      _previousPage = widget.pages[_currentIndex];
      _currentIndex = (_currentIndex - 1) % widget.pages.length;
    });

    _slideAnimation = _createSlideAnimation(const Offset(0, -1));

    _slideController.forward(from: 0);
    _fadeController.forward(from: 0);
    widget.onPageChanged?.call(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Previous page with fade out
        if (_previousPage != null)
          Positioned.fill(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _previousPage!,
            ),
          )
        else
          Positioned.fill(child: widget.pages[_currentIndex]),

        // Current page with slide in
        Positioned.fill(
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.pages[_currentIndex],
          ),
        ),

        // CTA Button
        Positioned(
          bottom: AppSpacing.md,
          left: AppSpacing.md,
          right: AppSpacing.md,
          child: PrimaryButton(
            text: widget.ctaLabels[_currentIndex],
            onPressed: _goToNextPage,
          ),
        ),

        // Close/Back button
        if (_currentIndex != 0)
          Positioned(
            top: 50,
            right: AppSpacing.md,
            child: IconButton(
              onPressed: _goToPreviousPage,
              icon: const Icon(Icons.close, color: AppColors.textPrimary),
            ),
          ),

        // Loading indicator
        if (_isAnimating)
          Positioned.fill(
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: AppColors.textPrimary,
                size: 100,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
