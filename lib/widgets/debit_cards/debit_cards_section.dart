import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/debit_card_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'debit_card_item.dart';

class DebitCardsSection extends StatelessWidget {
  const DebitCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final debitCards = context.select<HomeViewModel, List<DebitCardModel>>((vm) => vm.debitCards);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Get your easypaisa Debit Card",
            style: GoogleFonts.outfit(
              fontSize: 17.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1B232A),
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          // Two Debit Cards Side-by-Side
          Row(
            children: debitCards.map((card) {
              return DebitCardItem(
                card: card,
                onManageTap: () {
                  // Handle card manage tap
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
