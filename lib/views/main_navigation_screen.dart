import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/navigation/easypaisa_bottom_nav.dart';
import 'cash_points/cash_points_screen.dart';
import 'home/home_screen.dart';
import 'my_account/my_account_screen.dart';
import 'promotions/promotions_screen.dart';
import 'qr_scanner/qr_scanner_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    CashPointsScreen(),
    QrScannerScreen(),
    PromotionsScreen(),
    MyAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select<NavigationViewModel, int>((vm) => vm.currentIndex);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: const EasypaisaBottomNav(),
    );
  }
}
