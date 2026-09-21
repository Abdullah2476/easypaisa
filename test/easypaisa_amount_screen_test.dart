import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:easypaisa/data/easypaisa_contacts_data.dart';
import 'package:easypaisa/models/easypaisa_contact_model.dart';
import 'package:easypaisa/viewmodels/transfer_viewmodel.dart';
import 'package:easypaisa/views/send_money/easypaisa_amount_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_transfer_screen.dart';

void main() {
  const testReceiver = EasypaisaContactModel(
    id: '1',
    name: 'Flutter With Ahmad',
    phoneNumber: '03119818545',
    initials: 'FW',
  );

  test('easypaisaContactsRawData contains Flutter With Ahmad and filter with .where() works', () {
    // Verify raw list contains required contact
    expect(
      easypaisaContactsRawData.any((item) => item['name'] == 'Flutter With Ahmad' && item['phoneNumber'] == '03119818545'),
      isTrue,
    );

    // Verify .where() filter function works with phone number
    final phoneMatches = filterContactsByQuery('03119818545');
    expect(phoneMatches.length, 1);
    expect(phoneMatches.first.name, 'Flutter With Ahmad');
    expect(phoneMatches.first.initials, 'FW');

    // Verify .where() filter function works with partial name
    final nameMatches = filterContactsByQuery('Ahmad');
    expect(nameMatches.isNotEmpty, isTrue);
    expect(nameMatches.any((c) => c.name == 'Flutter With Ahmad'), isTrue);
  });

  testWidgets('EasypaisaAmountScreen renders mint header, receiver info, and amount controls', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TransferViewModel(),
        child: const MaterialApp(
          home: EasypaisaAmountScreen(receiver: testReceiver),
        ),
      ),
    );

    // Verify header and receiver
    expect(find.text('easypaisa Transfer'), findsOneWidget);
    expect(find.text('Sending to easypaisa account'), findsOneWidget);
    expect(find.text('FW'), findsOneWidget);
    expect(find.text('Flutter With Ahmad'), findsOneWidget);
    expect(find.text('03119818545'), findsOneWidget);

    // Verify amount section
    expect(find.text('Enter Amount'), findsOneWidget);
    expect(find.text('Rs. '), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Add a Message Here (Optional)'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Typing amount updates Rs. display and activates Next button', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TransferViewModel(),
        child: const MaterialApp(
          home: EasypaisaAmountScreen(receiver: testReceiver),
        ),
      ),
    );

    // Enter amount using hidden TextField
    final textFieldFinder = find.byType(TextField).first;
    await tester.enterText(textFieldFinder, '500');
    await tester.pumpAndSettle();

    // Amount display should now show 500
    expect(find.byWidgetPredicate((w) => w is Text && w.data == '500'), findsOneWidget);

    // Tap Next button to route to confirmation screen
    final nextBtnFinder = find.widgetWithText(ElevatedButton, 'Next');
    expect(nextBtnFinder, findsOneWidget);
    await tester.tap(nextBtnFinder);
    await tester.pumpAndSettle();

    // Verify routed to confirmation screen
    expect(find.text('Payment Summary'), findsOneWidget);
  });

  testWidgets('Writing number in EasypaisaTransferScreen filters and routes to EasypaisaAmountScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TransferViewModel(),
        child: const MaterialApp(
          home: EasypaisaTransferScreen(),
        ),
      ),
    );

    // Type number in receiver input field
    final phoneInputFinder = find.byType(TextField);
    await tester.enterText(phoneInputFinder, '03119818545');
    await tester.pumpAndSettle();

    // Contact suggestion appears using .where() filter
    expect(find.text('Flutter With Ahmad'), findsOneWidget);
    expect(find.text('03119818545'), findsWidgets);

    // Tap the filtered contact tile to navigate to Amount screen
    await tester.tap(find.text('Flutter With Ahmad'));
    await tester.pumpAndSettle();

    // EasypaisaAmountScreen is now open
    expect(find.text('Sending to easypaisa account'), findsOneWidget);
    expect(find.text('Enter Amount'), findsOneWidget);
    expect(find.text('Rs. '), findsOneWidget);
  });
}
