import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/promo_banner_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'promo_card.dart';

class WhatsNewCarousel extends StatelessWidget {
  const WhatsNewCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = context.select<HomeViewModel, List<PromoBannerModel>>((vm) => vm.promoBanners);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Tap to see what's new?",
              style: GoogleFonts.outfit(
                fontSize: 17.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1B232A),
                letterSpacing: -0.2,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Horizontal Promo Carousel
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return PromoCard(
                  banner: banners[index],
                  onTap: () {
                    // Handle banner tap
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
