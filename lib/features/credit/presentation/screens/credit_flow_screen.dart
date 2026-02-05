import 'package:flutter/material.dart';
import 'package:new_project/shared/widgets/animated_stack/animated_stack.dart';
import 'package:new_project/features/credit/presentation/pages/amount_selection_page.dart';
import 'package:new_project/features/credit/presentation/pages/emi_selection_page.dart';
import 'package:new_project/features/credit/presentation/pages/bank_selection_page.dart';

/// Main screen that orchestrates the credit flow through multiple steps
class CreditFlowScreen extends StatelessWidget {
  const CreditFlowScreen({super.key});

  static const List<String> _ctaLabels = [
    'Proceed to EMI selection',
    'Select your bank account',
    'Tap for 1 click KYC',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedStack(
        pages: const [
          AmountSelectionPage(),
          EmiSelectionPage(),
          BankSelectionPage(),
        ],
        ctaLabels: _ctaLabels,
        allowCycle: false,
      ),
    );
  }
}
