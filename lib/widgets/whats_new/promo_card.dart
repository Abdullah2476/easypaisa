import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_assets.dart';
import '../../models/promo_banner_model.dart';

class PromoCard extends StatelessWidget {
  final PromoBannerModel banner;
  final VoidCallback? onTap;

  const PromoCard({
    super.key,
    required this.banner,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 185,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: banner.borderGradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(2.2), // Gradient border width
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: banner.backgroundGradient,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: _buildCardContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    if (banner.id == 'banner_cornetto') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.cornetto,
                height: 75,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  banner.tagOffers.isNotEmpty ? banner.tagOffers.first : 'Special Offer',
                  style: GoogleFonts.outfit(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF4A1E05),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (banner.id == 'banner_1') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  AppAssets.billDoc,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "your first bill",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                  children: [
                    const TextSpan(text: "could win you "),
                    TextSpan(
                      text: banner.prizeAmount ?? "Rs. 5,000",
                      style: GoogleFonts.outfit(
                        color: const Color(0xFFCCFF00),
                        fontWeight: FontWeight.w800,
                        fontSize: 16.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (banner.id == 'banner_2') {
      return Stack(
        children: [
          const Center(
            child: Icon(
              Icons.receipt_long_rounded,
              color: Colors.white24,
              size: 80,
            ),
          ),
          Positioned(
            top: 14,
            left: 12,
            child: Text(
              banner.headline,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Rs. 530 on mondays",
                    style: GoogleFonts.outfit(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF004D25),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xCC002B15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Rs. 600 tuesdays-sundays",
                    style: GoogleFonts.outfit(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Banner 3 or default: Crazy deals
    return Stack(
      children: [
        const Center(
          child: Icon(
            Icons.local_offer_rounded,
            color: Colors.white24,
            size: 80,
          ),
        ),
        Positioned(
          top: 14,
          left: 10,
          child: Text(
            "crazy\nare...",
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF00E676),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "Rs. 700 on mondays",
              style: GoogleFonts.outfit(
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF004D25),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
