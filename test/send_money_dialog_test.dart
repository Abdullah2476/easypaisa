import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:easypaisa/viewmodels/home_viewmodel.dart';
import 'package:easypaisa/widgets/quick_actions/quick_actions_row.dart';
import 'package:easypaisa/widgets/send_money/send_money_card.dart';
import 'package:easypaisa/widgets/send_money/send_money_dialog.dart';

void main() {
  testWidgets('SendMoneyDialog renders all 6 options matching official UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SendMoneyDialog(),
        ),
      ),
    );

    // Verify Title
    expect(find.text('Send Money To'), findsOneWidget);

    // Verify all 6 options
    expect(find.text('easypaisa\nTransfer'), findsOneWidget);
    expect(find.text('Bank\nTransfer'), findsOneWidget);
    expect(find.text('CNIC\nTransfer'), findsOneWidget);
    expect(find.text('Raast\nPayment'), findsOneWidget);
    expect(find.text('Other Wallets'), findsOneWidget);
    expect(find.text('Scan QR'), findsOneWidget);

    // Verify SendMoneyCard widgets count
    expect(find.byType(SendMoneyCard), findsNWidgets(6));
  });

  testWidgets('Tapping Send Money quick action card opens SendMoneyDialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: QuickActionsRow(),
          ),
        ),
      ),
    );

    // Verify Send Money card exists
    expect(find.text('Send Money'), findsOneWidget);

    // Tap Send Money
    await tester.tap(find.text('Send Money'));
    await tester.pumpAndSettle();

    // Dialog should now be visible
    expect(find.text('Send Money To'), findsOneWidget);
    expect(find.text('easypaisa\nTransfer'), findsOneWidget);
    expect(find.text('Bank\nTransfer'), findsOneWidget);
    expect(find.text('CNIC\nTransfer'), findsOneWidget);
    expect(find.text('Raast\nPayment'), findsOneWidget);
    expect(find.text('Other Wallets'), findsOneWidget);
    expect(find.text('Scan QR'), findsOneWidget);

    // Tap an option to select and dismiss
    await tester.tap(find.text('Other Wallets'));
    await tester.pumpAndSettle();

    // Dialog dismissed
    expect(find.text('Send Money To'), findsNothing);
  });
}
