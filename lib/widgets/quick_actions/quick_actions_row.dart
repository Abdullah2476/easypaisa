import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/action_item_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../send_money/send_money_dialog.dart';
import 'quick_action_card.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final quickActions = context.select<HomeViewModel, List<ActionItemModel>>((vm) => vm.quickActions);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: quickActions.map((action) {
          return QuickActionCard(
            item: action,
            onTap: () {
              if (action.id == 'send_money') {
                showSendMoneyDialog(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
