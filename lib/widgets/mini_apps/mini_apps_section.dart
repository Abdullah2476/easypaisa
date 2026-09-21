import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/action_item_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../mascot/ello_mascot_widget.dart';
import 'mini_app_tile.dart';

class MiniAppsSection extends StatelessWidget {
  const MiniAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final miniApps = context.select<HomeViewModel, List<ActionItemModel>>((vm) => vm.miniApps);
    final activeIndex = context.select<HomeViewModel, int>((vm) => vm.miniAppsPageIndex);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Discover MiniApps on easypaisa",
            style: GoogleFonts.outfit(
              fontSize: 17.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1B232A),
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          // MiniApps Card with Ello Mascot
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.cardBorder, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.035),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // 4x2 Grid of MiniApps
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: miniApps.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 6,
                        childAspectRatio: 0.88,
                      ),
                      itemBuilder: (context, index) {
                        return MiniAppTile(
                          item: miniApps[index],
                          onTap: () {
                            // Handle mini-app tap
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // 3-dot Page Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
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

              // Standing Ello Mascot on bottom right of MiniApps
              const Positioned(
                right: 4,
                bottom: -25,
                child: ElloMascotWidget(size: 68),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
