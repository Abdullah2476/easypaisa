import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../models/action_item_model.dart';

class MiniAppTile extends StatelessWidget {
  final ActionItemModel item;
  final VoidCallback? onTap;

  const MiniAppTile({
    super.key,
    required this.item,
    this.onTap,
  });

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
              // Squircle Logo Icon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: item.iconBgColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: item.customIconKey == 'al_meezan'
                      ? Border.all(color: const Color(0xFF7B1FA2), width: 1.2)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: _buildMiniAppLogo(item.customIconKey),
                ),
              ),
              const SizedBox(height: 6),
              // Title
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2B333E),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // Top Badge (NEW / JOIN / Invest)
          if (item.badgeText != null)
            Positioned(
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                decoration: BoxDecoration(
                  color: item.badgeColor ?? AppColors.primaryGreen,
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

  Widget _buildMiniAppLogo(String? key) {
    switch (key) {
      case 'tapshop':
        return Text(
          "ts",
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        );
      case 'hbl_asset':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.double_arrow_rounded, color: Colors.white, size: 18),
            Text(
              "HBL",
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        );
      case 'kommittee':
        return const Icon(
          Icons.group_work_rounded,
          color: Colors.white,
          size: 22,
        );
      case 'bookme':
        return const Icon(
          Icons.confirmation_number_rounded,
          color: Colors.white,
          size: 22,
        );
      case 'bookkaru':
        return const Icon(
          Icons.airplane_ticket_rounded,
          color: Colors.white,
          size: 22,
        );
      case 'ktrade':
        return Text(
          "KTrade",
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
          ),
        );
      case 'al_meezan':
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF7B1FA2), width: 1.5),
          ),
          child: const Icon(
            Icons.account_balance,
            size: 16,
            color: Color(0xFF7B1FA2),
          ),
        );
      case 'more_miniapps':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              width: 5.5,
              height: 5.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryGreen, width: 1.5),
              ),
            );
          }),
        );
      default:
        return const Icon(Icons.apps, color: AppColors.primaryGreen, size: 24);
    }
  }
}
