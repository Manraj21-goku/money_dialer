import 'package:flutter/material.dart';
import 'package:new_project/core/theme/app_theme.dart';
import 'package:new_project/features/credit/presentation/screens/credit_flow_screen.dart';

void main() {
  runApp(const CreditApp());
}

class CreditApp extends StatelessWidget {
  const CreditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const CreditFlowScreen(),
    );
  }
}
