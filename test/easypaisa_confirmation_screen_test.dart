import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:easypaisa/models/easypaisa_contact_model.dart';
import 'package:easypaisa/viewmodels/transfer_viewmodel.dart';
import 'package:easypaisa/views/send_money/easypaisa_amount_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_confirmation_screen.dart';

void main() {
  const testReceiver = EasypaisaContactModel(
    id: '1',
    name: 'Sadiq Hussain',
    phoneNumber: '03299235015',
    initials: 'SH',
  );

  testWidgets('EasypaisaConfirmationScreen renders all components matching official UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EasypaisaConfirmationScreen(
          receiver: testReceiver,
          amount: '1',
        ),
      ),
    );

    // 1. Back button & Title
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    expect(find.text('easypaisa Transfer'), findsOneWidget);

    // 2. Pay From Card
    expect(find.text('Pay From'), findsOneWidget);
    expect(find.text('easypaisa'), findsOneWidget);
    expect(find.text('Balance Rs. 0.45'), findsOneWidget);

    // 3. Pay To Card
    expect(find.text('Pay To'), findsOneWidget);
    expect(find.text('Sadiq Hussain'), findsOneWidget);
    expect(find.text('Account Number :  03299235015'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // 4. Payment Summary Card
    expect(find.text('Payment Summary'), findsOneWidget);
    expect(find.text('Transfer amount'), findsOneWidget);
    expect(find.text('Rs. 1'), findsOneWidget);
    expect(find.text('Fee (including tax)'), findsOneWidget);
    expect(find.text('Free'), findsOneWidget);
    expect(find.text('Total Amount'), findsOneWidget);
    expect(find.text('Rs. 1.00'), findsOneWidget);

    // 5. Favourite Contact Card
    expect(find.text('Favourite Contact'), findsOneWidget);
    expect(find.text('Add this recipient as a favourite for easy'), findsOneWidget);

    // 6. Review Warning Banner
    expect(find.text('Please review the details carefully before sending money.'), findsOneWidget);
    expect(find.byIcon(Icons.info_rounded), findsOneWidget);

    // 7. Send Now Button
    expect(find.text('Send Now'), findsOneWidget);
  });

  testWidgets('Tapping Favourite Contact toggles checkbox', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EasypaisaConfirmationScreen(
          receiver: testReceiver,
          amount: '500',
        ),
      ),
    );

    // Initially un-checked
    expect(find.byIcon(Icons.check_rounded), findsOneWidget); // Only the Pay To checkmark

    // Tap to toggle
    await tester.tap(find.text('Favourite Contact'));
    await tester.pumpAndSettle();

    // Now checked (two checkmarks on screen)
    expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));
  });

  testWidgets('Tapping Next in Amount Screen routes to Confirmation Screen with exact data', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TransferViewModel(),
        child: const MaterialApp(
          home: EasypaisaAmountScreen(receiver: testReceiver),
        ),
      ),
    );

    // Enter amount
    final textField = find.byType(TextField).first;
    await tester.enterText(textField, '500');
    await tester.pumpAndSettle();

    // Tap Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify on confirmation screen with matching details
    expect(find.text('Pay From'), findsOneWidget);
    expect(find.text('Pay To'), findsOneWidget);
    expect(find.text('Sadiq Hussain'), findsOneWidget);
    expect(find.text('Account Number :  03299235015'), findsOneWidget);
    expect(find.text('Rs. 500'), findsOneWidget);
    expect(find.text('Rs. 500.00'), findsOneWidget);
    expect(find.text('Send Now'), findsOneWidget);

    // Scroll down and Tap Send Now
    await tester.scrollUntilVisible(find.text('Send Now'), 100);
    await tester.tap(find.text('Send Now'));
    await tester.pumpAndSettle();

    // Verify success screen is opened
    expect(find.text('Successfully Sent to'), findsOneWidget);
    expect(find.text('View Receipt'), findsOneWidget);
  });
}
