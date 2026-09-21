import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/send_money_option_model.dart';

/// An individual destination card in the "Send Money To" dialog.
/// Displays an asset image on top and the label text below inside a rounded border.
class SendMoneyCard extends StatelessWidget {
  final SendMoneyOptionModel option;
  final VoidCallback? onTap;

  const SendMoneyCard({
    super.key,
    required this.option,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? option.onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFF00A859).withValues(alpha: 0.1),
        highlightColor: const Color(0xFF00A859).withValues(alpha: 0.05),
        child: Container(
          height: 108,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Asset Icon (no painters, pure Image.asset as requested)
              SizedBox(
                height: 38,
                width: 38,
                child: Center(
                  child: Image.asset(
                    option.imageAsset,
                    height: 38,
                    width: 38,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 32,
                      color: Color(0xFF00A859),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Title Label (e.g. "easypaisa\nTransfer", "Bank\nTransfer")
              Text(
                option.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E242B),
                  height: 1.18,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
