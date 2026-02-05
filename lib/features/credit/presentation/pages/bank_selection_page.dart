import 'package:flutter/material.dart';
import 'package:new_project/core/theme/app_theme.dart';
import 'package:new_project/core/constants/app_constants.dart';

/// Third page in the credit flow - allows user to select bank account
class BankSelectionPage extends StatefulWidget {
  const BankSelectionPage({super.key});

  @override
  State<BankSelectionPage> createState() => _BankSelectionPageState();
}

class _BankSelectionPageState extends State<BankSelectionPage> {
  bool _isAccountSelected = false;

  void _toggleAccountSelection() {
    setState(() {
      _isAccountSelected = !_isAccountSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            const _HeaderSection(),
            const SizedBox(height: AppSpacing.lg),
            _BankAccountCard(
              isSelected: _isAccountSelected,
              onTap: _toggleAccountSelection,
            ),
            const SizedBox(height: AppSpacing.xl),
            const _ChangeAccountButton(),
          ],
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'where should we send the money?',
          style: AppTextStyles.headingSecondary,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'amount will be credited to this bank account, EMI will be debited from this bank account',
          style: AppTextStyles.bodySecondary,
        ),
      ],
    );
  }
}

// ============================================================================
// BANK ACCOUNT CARD
// ============================================================================

class _BankAccountCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _BankAccountCard({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BankLogo(),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _AccountDetails(
            isSelected: isSelected,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// BANK LOGO
// ============================================================================

class _BankLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: const Image(
        image: AssetImage(AppAssets.hdfcLogo),
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      ),
    );
  }
}

// ============================================================================
// ACCOUNT DETAILS
// ============================================================================

class _AccountDetails extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _AccountDetails({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Stack(
          children: [
            // Bank name and account number
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HDFC Bank',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'XXXX XXXX 1234',
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            // Selection indicator
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Icon(
                isSelected ? Icons.check_circle : Icons.account_balance_rounded,
                color: isSelected ? AppColors.accent : AppColors.textPrimary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// CHANGE ACCOUNT BUTTON
// ============================================================================

class _ChangeAccountButton extends StatelessWidget {
  const _ChangeAccountButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle change account
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textPrimary),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: AppColors.textPrimary, size: 18),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Change Account',
              style: AppTextStyles.body.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
