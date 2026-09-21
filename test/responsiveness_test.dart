import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:easypaisa/models/easypaisa_contact_model.dart';
import 'package:easypaisa/viewmodels/home_viewmodel.dart';
import 'package:easypaisa/viewmodels/navigation_viewmodel.dart';
import 'package:easypaisa/viewmodels/transfer_viewmodel.dart';
import 'package:easypaisa/views/cash_points/cash_points_screen.dart';
import 'package:easypaisa/views/home/home_screen.dart';
import 'package:easypaisa/views/my_account/my_account_screen.dart';
import 'package:easypaisa/views/promotions/promotions_screen.dart';
import 'package:easypaisa/views/qr_scanner/qr_scanner_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_amount_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_confirmation_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_success_screen.dart';
import 'package:easypaisa/views/send_money/easypaisa_transfer_screen.dart';
import 'package:easypaisa/widgets/receipt/easypaisa_receipt_dialog.dart';
import 'package:easypaisa/widgets/send_money/send_money_dialog.dart';

Widget _createTestApp(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ChangeNotifierProvider(create: (_) => TransferViewModel()),
    ],
    child: MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  const testReceiver = EasypaisaContactModel(
    id: '1',
    name: 'Sadiq Hussain',
    phoneNumber: '03299235015',
    initials: 'SH',
  );

  const testScreens = [
    Size(320, 568), // Small phone (iPhone SE 1st gen)
    Size(390, 844), // Standard phone (iPhone 14)
    Size(412, 915), // Large phone (Pixel 7)
    Size(768, 1024), // Tablet (iPad)
    Size(1200, 800), // Desktop / Web landscape
  ];

  for (final size in testScreens) {
    group('Responsiveness tests on ${size.width}x${size.height}', () {
      testWidgets('HomeScreen renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_createTestApp(const HomeScreen()));
        await tester.pumpAndSettle();

        expect(find.text('easypaisa Account'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('EasypaisaReceiptDialog renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          _createTestApp(
            const EasypaisaReceiptDialog(
              receiver: testReceiver,
              amount: '500',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Transaction Successful'), findsOneWidget);
        expect(find.text('Rs. 500.00'), findsOneWidget);
        expect(find.text('Share'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('SendMoneyDialog renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_createTestApp(const SendMoneyDialog()));
        await tester.pumpAndSettle();

        expect(find.text('Send Money To'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('EasypaisaTransferScreen renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_createTestApp(const EasypaisaTransferScreen()));
        await tester.pumpAndSettle();

        expect(find.text('easypaisa Transfer'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('EasypaisaAmountScreen renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_createTestApp(const EasypaisaAmountScreen(receiver: testReceiver)));
        await tester.pumpAndSettle();

        expect(find.text('Enter Amount'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('EasypaisaConfirmationScreen renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          _createTestApp(
            const EasypaisaConfirmationScreen(
              receiver: testReceiver,
              amount: '100',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Payment Summary'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('EasypaisaSuccessScreen renders without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          _createTestApp(
            const EasypaisaSuccessScreen(
              receiver: testReceiver,
              amount: '100',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Successfully Sent to'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Auxiliary screens render without overflow', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_createTestApp(const CashPointsScreen()));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(_createTestApp(const QrScannerScreen()));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(_createTestApp(const PromotionsScreen()));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(_createTestApp(const MyAccountScreen()));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    });
  }
}
