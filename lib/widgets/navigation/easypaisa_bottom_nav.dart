import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/navigation_viewmodel.dart';

class EasypaisaBottomNav extends StatelessWidget {
  const EasypaisaBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select<NavigationViewModel, int>((vm) => vm.currentIndex);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE8ECEE), width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 1. Home Tab
                  _buildNavItem(
                    context: context,
                    index: 0,
                    selectedIndex: selectedIndex,
                    label: "Home",
                    icon: Icons.home_rounded,
                  ),

                  // 2. Cash Points Tab
                  _buildNavItem(
                    context: context,
                    index: 1,
                    selectedIndex: selectedIndex,
                    label: "Cash Points",
                    icon: Icons.location_on_outlined,
                  ),

                  // 3. Center Elevated Glowing QR Scanner Button
                  GestureDetector(
                    onTap: () => context.read<NavigationViewModel>().setIndex(2),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF00E676),
                            Color(0xFF00A859),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x6600A859),
                            blurRadius: 12,
                            spreadRadius: 1,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),

                  // 4. Promotions Tab
                  _buildNavItem(
                    context: context,
                    index: 3,
                    selectedIndex: selectedIndex,
                    label: "Promotions",
                    icon: Icons.campaign_outlined,
                  ),

                  // 5. My Account Tab
                  _buildNavItem(
                    context: context,
                    index: 4,
                    selectedIndex: selectedIndex,
                    label: "My Account",
                    icon: Icons.person_outline_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required int selectedIndex,
    required String label,
    required IconData icon,
  }) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? AppColors.primaryGreen : const Color(0xFF6B7A85);

    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<NavigationViewModel>().setIndex(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Green Indicator Line
            Container(
              width: 38,
              height: 2.8,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
              ),
            ),

            // Icon
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                icon,
                size: 24,
                color: color,
              ),
            ),

            // Label
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
