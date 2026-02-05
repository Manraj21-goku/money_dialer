import 'package:flutter/material.dart';
import 'package:new_project/core/theme/app_theme.dart';

/// Second page in the credit flow - allows user to select EMI plan
class EmiSelectionPage extends StatefulWidget {
  const EmiSelectionPage({super.key});

  @override
  State<EmiSelectionPage> createState() => _EmiSelectionPageState();
}

class _EmiSelectionPageState extends State<EmiSelectionPage> {
  int _selectedPlanIndex = -1;

  static const List<EmiPlan> _plans = [
    EmiPlan(months: 3, color: Colors.grey),
    EmiPlan(months: 6, color: Colors.purpleAccent),
    EmiPlan(months: 9, color: Colors.orange),
    EmiPlan(months: 12, color: Colors.indigo),
    EmiPlan(months: 18, color: Colors.amber),
    EmiPlan(months: 24, color: Colors.teal),
  ];

  void _selectPlan(int index) {
    setState(() {
      _selectedPlanIndex = _selectedPlanIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          const _HeaderSection(),
          _PlanList(
            plans: _plans,
            selectedIndex: _selectedPlanIndex,
            onPlanSelected: _selectPlan,
          ),
          const _CreatePlanButton(),
        ],
      ),
    );
  }
}

// ============================================================================
// DATA MODEL
// ============================================================================

class EmiPlan {
  final int months;
  final Color color;

  const EmiPlan({required this.months, required this.color});
}

// ============================================================================
// HEADER SECTION
// ============================================================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'how do you wish to repay?',
            style: AppTextStyles.headingSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'choose one of our recommended plans or make your own',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PLAN LIST
// ============================================================================

class _PlanList extends StatelessWidget {
  final List<EmiPlan> plans;
  final int selectedIndex;
  final ValueChanged<int> onPlanSelected;

  const _PlanList({
    required this.plans,
    required this.selectedIndex,
    required this.onPlanSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          return _PlanCard(
            plan: plans[index],
            planNumber: index + 1,
            isSelected: selectedIndex == index,
            onTap: () => onPlanSelected(index),
          );
        },
      ),
    );
  }
}

// ============================================================================
// PLAN CARD
// ============================================================================

class _PlanCard extends StatelessWidget {
  final EmiPlan plan;
  final int planNumber;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.planNumber,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: plan.color,
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SelectionIndicator(isSelected: isSelected),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Plan $planNumber',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${plan.months} months',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SELECTION INDICATOR
// ============================================================================

class _SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const _SelectionIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return const Icon(Icons.check_circle, color: AppColors.accent, size: 28);
    }
    
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black26),
        color: Colors.grey.shade200,
      ),
    );
  }
}

// ============================================================================
// CREATE PLAN BUTTON
// ============================================================================

class _CreatePlanButton extends StatelessWidget {
  const _CreatePlanButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: GestureDetector(
        onTap: () {
          // Handle create custom plan
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderLight),
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Text(
            'Create your own plan',
            style: AppTextStyles.bodySecondary.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
