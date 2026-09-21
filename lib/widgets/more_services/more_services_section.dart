import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/action_item_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'service_tile.dart';

class MoreServicesSection extends StatelessWidget {
  const MoreServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = context.select<HomeViewModel, List<ActionItemModel>>((vm) => vm.moreServices);
    final activeIndex = context.select<HomeViewModel, int>((vm) => vm.moreServicesPageIndex);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "More with easypaisa",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1B232A),
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 8),

          // White Container with 4x3 Grid
          Container(
            padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder, width: 1.1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // 4-column Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    return ServiceTile(
                      item: services[index],
                      onTap: () {
                        // Handle service tap
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),

                // 2-dot Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    final isActive = index == activeIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primaryGreen : AppColors.inactiveDot,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
