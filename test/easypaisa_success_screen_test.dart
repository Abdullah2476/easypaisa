import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easypaisa/models/easypaisa_contact_model.dart';
import 'package:easypaisa/views/send_money/easypaisa_confirmation_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_success_screen.dart';

void main() {
  const testReceiver = EasypaisaContactModel(
    id: '1',
    name: 'Sadiq Hussain',
    phoneNumber: '03299235015',
    initials: 'SH',
  );

  testWidgets('EasypaisaSuccessScreen renders celebration check, amount, receiver and actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EasypaisaSuccessScreen(
          receiver: testReceiver,
          amount: '1',
        ),
      ),
    );

    // Let celebration animation finish
    await tester.pumpAndSettle();

    // 1. Close 'X' Button
    expect(find.byIcon(Icons.close_rounded), findsOneWidget);

    // 2. Celebration Checkmark
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // 3. Amount Display
    expect(find.text('Rs. '), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('.00'), findsOneWidget);

    // 4. "Successfully Sent to"
    expect(find.text('Successfully Sent to'), findsOneWidget);

    // 5. Receiver Profile (Avatar placeholder, Name, Number)
    expect(find.text('SH'), findsOneWidget);
    expect(find.text('Sadiq Hussain'), findsOneWidget);
    expect(find.text('03299235015'), findsOneWidget);

    // 6. Action Rows
    expect(find.text('View Receipt'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long_outlined), findsOneWidget);
    expect(find.byIcon(Icons.share_outlined), findsOneWidget);
  });

  testWidgets('Tapping View Receipt opens receipt dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EasypaisaSuccessScreen(
          receiver: testReceiver,
          amount: '1',
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap View Receipt
    await tester.tap(find.text('View Receipt'));
    await tester.pumpAndSettle();

    // Receipt dialog appears matching official UI
    expect(find.text('Transaction Successful'), findsOneWidget);
    expect(find.text('Money has been sent'), findsOneWidget);
    expect(find.text('Funding Source'), findsOneWidget);
    expect(find.text('easypaisa Account'), findsOneWidget);
    expect(find.text('Sent to'), findsOneWidget);
    expect(find.text('Account Details'), findsOneWidget);
    expect(find.text('Sent by'), findsOneWidget);
    expect(find.text('AHMED BILAL'), findsOneWidget);
    expect(find.text('03119818545'), findsOneWidget);
    expect(find.text('Fee / Charge'), findsOneWidget);
    expect(find.text('No Charge'), findsOneWidget);
    expect(find.text('Total Amount'), findsOneWidget);
    expect(find.text('Rs. 1.00'), findsOneWidget);
    expect(find.text('Share'), findsWidgets);
    expect(find.text('Save to Gallery'), findsOneWidget);
    expect(find.text('Save as PDF'), findsOneWidget);

    // Close receipt via top-right 'X' icon
    await tester.tap(find.byIcon(Icons.close_rounded).last);
    await tester.pumpAndSettle();

    expect(find.text('Transaction Successful'), findsNothing);
  });

  testWidgets('Tapping Send Now in Confirmation Screen routes to Success Screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EasypaisaConfirmationScreen(
          receiver: testReceiver,
          amount: '1',
        ),
      ),
    );

    // Scroll down and tap Send Now
    await tester.scrollUntilVisible(find.text('Send Now'), 100);
    await tester.tap(find.text('Send Now'));
    await tester.pumpAndSettle();

    // Verify on Success Screen
    expect(find.text('Successfully Sent to'), findsOneWidget);
    expect(find.text('Sadiq Hussain'), findsOneWidget);
    expect(find.text('03299235015'), findsOneWidget);
    expect(find.text('View Receipt'), findsOneWidget);
  });
}
