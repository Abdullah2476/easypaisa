import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/action_item_model.dart';

class QuickActionCard extends StatelessWidget {
  final ActionItemModel item;
  final VoidCallback? onTap;

  const QuickActionCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEFF2F4), width: 0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Container
              SizedBox(
                height: 42,
                child: Center(child: _buildIcon(item.customIconKey)),
              ),
              const SizedBox(height: 6),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E242B),
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String? iconKey) {
    switch (iconKey) {
      case 'send_money':
        return Image.asset(
          AppAssets.sendMoney,
          width: 44,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'bill_payment':
        return Image.asset(
          AppAssets.billPayment,
          width: 34,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'mobile_packages':
        // Missing in assets/images - clean placeholder
        return const Icon(
          Icons.phone_android_rounded,
          color: AppColors.primaryGreen,
          size: 34,
        );
      default:
        return const Icon(
          Icons.send_rounded,
          color: AppColors.primaryGreen,
          size: 30,
        );
    }
  }
}
