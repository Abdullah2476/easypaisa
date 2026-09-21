import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/send_money_option_model.dart';
import '../../views/send_money/easypaisa_transfer_screen.dart';
import 'send_money_card.dart';

/// Function to show the "Send Money To" dialog over the current screen.
Future<void> showSendMoneyDialog(
  BuildContext context, {
  List<SendMoneyOptionModel>? options,
  void Function(SendMoneyOptionModel option)? onSelect,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (BuildContext dialogContext) {
      return SendMoneyDialog(options: options, onSelect: onSelect);
    },
  );
}

/// Custom Dialog displaying the "Send Money To" grid options.
/// Strictly matches the official Easypaisa UI with 3x2 rounded cards.
class SendMoneyDialog extends StatelessWidget {
  final List<SendMoneyOptionModel>? options;
  final void Function(SendMoneyOptionModel option)? onSelect;

  const SendMoneyDialog({super.key, this.options, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final list = options ?? SendMoneyOptionModel.defaultOptions;

    final screenWidth = MediaQuery.of(context).size.width;
    final cardSpacing = screenWidth < 360 ? 12.0 : 20.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
      elevation: 0,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 96),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Modal Title
                Text(
                  'Send Money To',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E242B),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 20),

                // Row 1: easypaisa Transfer, Bank Transfer, CNIC Transfer
                if (list.length >= 3)
                  Row(
                    children: [
                      Expanded(
                        child: SendMoneyCard(
                          option: list[0],
                          onTap: () => _handleTap(context, list[0]),
                        ),
                      ),
                      SizedBox(width: cardSpacing),
                      Expanded(
                        child: SendMoneyCard(
                          option: list[1],
                          onTap: () => _handleTap(context, list[1]),
                        ),
                      ),
                      SizedBox(width: cardSpacing),
                      Expanded(
                        child: SendMoneyCard(
                          option: list[2],
                          onTap: () => _handleTap(context, list[2]),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 24),

                // Row 2: Raast Payment, Other Wallets, Scan QR
                if (list.length >= 6)
                  Row(
                    children: [
                      Expanded(
                        child: SendMoneyCard(
                          option: list[3],
                          onTap: () => _handleTap(context, list[3]),
                        ),
                      ),
                      SizedBox(width: cardSpacing),
                      Expanded(
                        child: SendMoneyCard(
                          option: list[4],
                          onTap: () => _handleTap(context, list[4]),
                        ),
                      ),
                      SizedBox(width: cardSpacing),
                      Expanded(
                        child: SendMoneyCard(
                          option: list[5],
                          onTap: () => _handleTap(context, list[5]),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, SendMoneyOptionModel option) {
    Navigator.of(context, rootNavigator: true).pop();
    if (onSelect != null) {
      onSelect!(option);
    } else if (option.id == 'easypaisa_transfer') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const EasypaisaTransferScreen(),
        ),
      );
    } else if (option.onTap != null) {
      option.onTap!();
    } else {
      // Feedback snackbar or navigation for demo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected: ${option.title.replaceAll('\n', ' ')}'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
