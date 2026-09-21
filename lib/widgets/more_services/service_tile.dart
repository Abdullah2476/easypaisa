import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/action_item_model.dart';

class ServiceTile extends StatelessWidget {
  final ActionItemModel item;
  final VoidCallback? onTap;

  const ServiceTile({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Container
              SizedBox(
                width: 38,
                height: 38,
                child: Center(child: _buildIcon(item.customIconKey)),
              ),
              const SizedBox(height: 3),
              // Label
              Flexible(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2B333E),
                    height: 1.15,
                    letterSpacing: -0.1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          // Optional Badge (e.g. "Reward")
          if (item.badgeText != null && item.customIconKey != 'savings_pocket')
            Positioned(
              top: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1.5,
                ),
                decoration: BoxDecoration(
                  color: item.badgeColor ?? const Color(0xFFE5A93C),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.badgeText!,
                  style: GoogleFonts.outfit(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIcon(String? key) {
    switch (key) {
      case 'easyload':
        return Image.asset(
          AppAssets.easyload,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'easycash':
        return Image.asset(
          AppAssets.easycash,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'savings_pocket':
        return Image.asset(
          AppAssets.savingsPocket,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'invite_earn':
        return Image.asset(
          AppAssets.inviteEarn,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'donations':
        return Image.asset(
          AppAssets.donations,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'term_deposit':
        return Image.asset(
          AppAssets.termDeposit,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'daily_rewards':
        return Image.asset(
          AppAssets.dailyRewards,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'bnpl':
        return Image.asset(
          AppAssets.bnpl,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'insurance':
        return Image.asset(
          AppAssets.insurance,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'see_all':
        return Image.asset(
          AppAssets.seeAll,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'mtag':
        return Image.asset(
          AppAssets.mtag,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      // Missing in assets/images -> clean placeholders
      case 'rs1_game':
        return const Icon(
          Icons.sports_esports_rounded,
          color: Colors.white,
          size: 28,
        );
      default:
        return const Icon(
          Icons.widgets_outlined,
          color: AppColors.primaryGreen,
          size: 28,
        );
    }
  }
}
