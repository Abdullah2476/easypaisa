import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:easypaisa/viewmodels/transfer_viewmodel.dart';
import 'package:easypaisa/views/send_money/easypaisa_transfer_screen.dart';
import 'package:easypaisa/widgets/send_money/send_money_dialog.dart';

Widget _buildTestApp(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => TransferViewModel(),
    child: MaterialApp(
      home: child,
    ),
  );
}

void main() {
  testWidgets('EasypaisaTransferScreen renders all components matching screenshot', (WidgetTester tester) async {
    await tester.pumpWidget(
      _buildTestApp(const EasypaisaTransferScreen()),
    );

    // 1. App Bar
    expect(find.text('easypaisa Transfer'), findsOneWidget);
    expect(find.text('Help'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

    // 2. Tabs
    expect(find.text('Send Money'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);

    // 3. Favourites Row
    expect(find.text('My Easypaisa Favourites'), findsOneWidget);
    expect(find.text('See All'), findsOneWidget);

    // 4. Segmented Control
    expect(find.text('Mobile No.'), findsOneWidget);
    expect(find.text('Digital Account No'), findsOneWidget);

    // 5. Input Section
    expect(find.text("Enter Receiver's Mobile Number"), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Enter Receiver's Number or select from contacts"), findsOneWidget);
    expect(find.byIcon(Icons.search_rounded), findsOneWidget);
  });

  testWidgets('Receiver mobile number text field accepts input and updates value', (WidgetTester tester) async {
    await tester.pumpWidget(
      _buildTestApp(const EasypaisaTransferScreen()),
    );

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    // Enter phone number
    await tester.enterText(textFieldFinder, '03451234567');
    await tester.pump();

    // Verify text field holds entered value
    expect(find.text('03451234567'), findsOneWidget);
  });

  testWidgets('Switching between Mobile No. and Digital Account No updates label & hint', (WidgetTester tester) async {
    await tester.pumpWidget(
      _buildTestApp(const EasypaisaTransferScreen()),
    );

    // Tap Digital Account No
    await tester.tap(find.text('Digital Account No'));
    await tester.pumpAndSettle();

    expect(find.text("Enter Receiver's Digital Account Number"), findsOneWidget);
    expect(find.text("Enter 11-digit Digital Account Number"), findsOneWidget);

    // Tap back to Mobile No.
    await tester.tap(find.text('Mobile No.'));
    await tester.pumpAndSettle();

    expect(find.text("Enter Receiver's Mobile Number"), findsOneWidget);
  });

  testWidgets('Switching tabs to History shows history view', (WidgetTester tester) async {
    await tester.pumpWidget(
      _buildTestApp(const EasypaisaTransferScreen()),
    );

    // Tap History tab
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();

    expect(find.text('No recent transfers found'), findsOneWidget);

    // Tap Send Money tab
    await tester.tap(find.text('Send Money'));
    await tester.pumpAndSettle();

    expect(find.text("Enter Receiver's Mobile Number"), findsOneWidget);
  });

  testWidgets('Tapping easypaisa Transfer in dialog navigates to EasypaisaTransferScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TransferViewModel(),
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => showSendMoneyDialog(context),
                child: const Text('Open Dialog'),
              ),
            ),
          ),
        ),
      ),
    );

    // Open dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    // Tap easypaisa Transfer option
    expect(find.text('easypaisa\nTransfer'), findsOneWidget);
    await tester.tap(find.text('easypaisa\nTransfer'));
    await tester.pumpAndSettle();

    // EasypaisaTransferScreen should now be on screen
    expect(find.text('easypaisa Transfer'), findsOneWidget);
    expect(find.text("Enter Receiver's Mobile Number"), findsOneWidget);

    // Test back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // Back to main screen
    expect(find.text('Open Dialog'), findsOneWidget);
  });
}
