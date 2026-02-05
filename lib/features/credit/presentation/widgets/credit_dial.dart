import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_project/core/theme/app_theme.dart';

/// Interactive dial widget for selecting credit amount
class CreditDial extends StatefulWidget {
  final double initialAmount;
  final double interestRate;
  final double maxAmount;
  final double minAmount;
  final ValueChanged<double>? onAmountChanged;

  const CreditDial({
    super.key,
    required this.initialAmount,
    required this.interestRate,
    this.maxAmount = 487891,
    this.minAmount = 0,
    this.onAmountChanged,
  });

  @override
  State<CreditDial> createState() => _CreditDialState();
}

class _CreditDialState extends State<CreditDial> {
  // Dial dimensions
  static const double _containerSize = 400;
  static const double _dialSize = 200;
  static const double _dialRadius = _dialSize / 2;
  static const double _indicatorSize = 16;
  static const double _arcStrokeWidth = 5;
  static const double _borderStrokeWidth = 2;

  late double _currentAmount;
  late double _angle;

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.initialAmount;
    _angle = _amountToAngle(_currentAmount);
  }

  double _amountToAngle(double amount) {
    return (amount / widget.maxAmount) * 2 * pi;
  }

  double _angleToAmount(double angle) {
    return (angle / (2 * pi)) * widget.maxAmount;
  }

  double _positionToAngle(Offset position) {
    final center = const Offset(_containerSize / 2, _containerSize / 2);
    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;
    var angle = atan2(dy, dx) + pi / 2;
    if (angle < 0) angle += 2 * pi;
    return angle;
  }

  void _handleDrag(Offset localPosition) {
    final angle = _positionToAngle(localPosition);
    final amount = _angleToAmount(angle).clamp(widget.minAmount, widget.maxAmount);

    setState(() {
      _angle = angle;
      _currentAmount = amount;
    });

    widget.onAmountChanged?.call(_currentAmount);
  }

  Offset _getIndicatorOffset() {
    final adjustedAngle = _angle - pi / 2;
    final radius = _dialRadius - 5;
    return Offset(
      _dialRadius + radius * cos(adjustedAngle),
      _dialRadius + radius * sin(adjustedAngle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _handleDrag(details.localPosition),
      onPanUpdate: (details) => _handleDrag(details.localPosition),
      child: SizedBox(
        width: _containerSize,
        height: _containerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _DialRing(
              angle: _angle,
              indicatorOffset: _getIndicatorOffset(),
              dialSize: _dialSize,
              indicatorSize: _indicatorSize,
              arcStrokeWidth: _arcStrokeWidth,
              borderStrokeWidth: _borderStrokeWidth,
            ),
            _AmountDisplay(
              amount: _currentAmount,
              interestRate: widget.interestRate,
            ),
            const _FooterCaption(),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// DIAL RING
// ============================================================================

class _DialRing extends StatelessWidget {
  final double angle;
  final Offset indicatorOffset;
  final double dialSize;
  final double indicatorSize;
  final double arcStrokeWidth;
  final double borderStrokeWidth;

  const _DialRing({
    required this.angle,
    required this.indicatorOffset,
    required this.dialSize,
    required this.indicatorSize,
    required this.arcStrokeWidth,
    required this.borderStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dialSize,
      height: dialSize,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(dialSize, dialSize),
            painter: _DialPainter(
              arcAngle: angle,
              arcStrokeWidth: arcStrokeWidth,
              borderStrokeWidth: borderStrokeWidth,
            ),
          ),
          Positioned(
            left: indicatorOffset.dx - indicatorSize / 2,
            top: indicatorOffset.dy - indicatorSize / 2,
            child: Container(
              width: indicatorSize,
              height: indicatorSize,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// DIAL PAINTER
// ============================================================================

class _DialPainter extends CustomPainter {
  final double arcAngle;
  final double arcStrokeWidth;
  final double borderStrokeWidth;

  _DialPainter({
    required this.arcAngle,
    required this.arcStrokeWidth,
    required this.borderStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw circle border
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderStrokeWidth;

    canvas.drawCircle(center, radius - 2.5, borderPaint);

    // Draw progress arc
    final arcPaint = Paint()
      ..color = AppColors.success
      ..strokeWidth = arcStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) {
    return oldDelegate.arcAngle != arcAngle;
  }
}

// ============================================================================
// AMOUNT DISPLAY
// ============================================================================

class _AmountDisplay extends StatelessWidget {
  final double amount;
  final double interestRate;

  const _AmountDisplay({
    required this.amount,
    required this.interestRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Credit Amount', style: AppTextStyles.label),
        Text('₹${amount.toStringAsFixed(0)}', style: AppTextStyles.amountLarge),
        Text(
          '@ ${interestRate.toStringAsFixed(2)}% monthly',
          style: AppTextStyles.rate,
        ),
      ],
    );
  }
}

// ============================================================================
// FOOTER CAPTION
// ============================================================================

class _FooterCaption extends StatelessWidget {
  const _FooterCaption();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Text(
          'Stash is instant, money will be credited within seconds',
          style: AppTextStyles.caption,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
