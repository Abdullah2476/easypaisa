import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/action_banners/customer_support_card.dart';
import '../../widgets/action_banners/schedule_transactions_card.dart';
import '../../widgets/app_bar/digital_bank_app_bar.dart';
import '../../widgets/account_card/account_card_widget.dart';
import '../../widgets/debit_cards/debit_cards_section.dart';
import '../../widgets/mini_apps/mini_apps_section.dart';
import '../../widgets/more_services/more_services_section.dart';
import '../../widgets/quick_actions/quick_actions_row.dart';
import '../../widgets/whats_new/whats_new_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Stack(
              children: [
                // Header Gradient Background (fades into #F4F4F6)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 245,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.headerGradient,
                    ),
                  ),
                ),

                // Scrollable Content
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // 1. Digital Bank Custom App Bar (with exact yellow-green gradient)
                      DigitalBankAppBar(),

                      // 2. Easypaisa Emerald Account Card
                      AccountCardWidget(),

                      // 3. Quick Actions 3-Card Row
                      SizedBox(height: 12),
                      QuickActionsRow(),
                      SizedBox(height: 10),

                      // 4. "More with easypaisa" 12-Item Grid (No mascot on bottom right)
                      MoreServicesSection(),
                      SizedBox(height: 10),

                      // 5. "Get your easypaisa Debit Card" Section
                      DebitCardsSection(),
                      SizedBox(height: 10),

                      // 6. "Discover MiniApps on easypaisa" Section (With Ello Mascot)
                      MiniAppsSection(),
                      SizedBox(height: 10),

                      // 7. "Tap to see what's new?" Promo Carousel
                      WhatsNewCarousel(),
                      SizedBox(height: 10),

                      // 8. "Schedule Your Transactions" Card
                      ScheduleTransactionsCard(),
                      SizedBox(height: 10),

                      // 9. "Help & Customer Support" Card (With Ask Ello)
                      CustomerSupportCard(),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
