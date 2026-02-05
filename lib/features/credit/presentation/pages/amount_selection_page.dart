import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_project/core/theme/app_theme.dart';
import 'package:new_project/core/constants/app_constants.dart';
import 'package:new_project/features/credit/presentation/widgets/credit_dial.dart';

/// First page in the credit flow - allows user to select credit amount
class AmountSelectionPage extends StatelessWidget {
  const AmountSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: Stack(
        children: [
          const _HeaderSection(),
          Center(
            child: _CreditCard(
              child: CreditDial(
                initialAmount: AppConstants.defaultCreditAmount,
                interestRate: AppConstants.defaultInterestRate,
                maxAmount: AppConstants.maxCreditAmount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// HEADER SECTION
// ============================================================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      left: AppSpacing.lg,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppConstants.userName}, how much do you need?',
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'move the dial and set any amount you need upto ${AppConstants.maxCreditAmount.toStringAsFixed(0)}',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// CREDIT CARD CONTAINER
// ============================================================================

class _CreditCard extends StatelessWidget {
  final Widget child;

  const _CreditCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 350,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surfaceDark, width: 3),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================================
// CREDIT DIAL - Moved to separate widget file
// ============================================================================

// See: lib/features/credit/presentation/widgets/credit_dial.dart
