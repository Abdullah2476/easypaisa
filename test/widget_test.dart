import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easypaisa/main.dart';

void main() {
  testWidgets('EasypaisaApp smoke test & UI component verification', (WidgetTester tester) async {
    await tester.pumpWidget(const EasypaisaApp());
    await tester.pumpAndSettle();

    // 1. App Bar and Account Card
    expect(find.text('easypaisa Account'), findsOneWidget);
    expect(find.text('AHMED BILAL'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    // 2. Quick Actions (Exact 3 Cards from Image 2)
    expect(find.text('Send Money'), findsOneWidget);
    expect(find.text('Bill Payment'), findsOneWidget);
    expect(find.text('Mobile Packages'), findsOneWidget);

    // 3. More with easypaisa (12 Services Grid)
    expect(find.text('More with easypaisa'), findsOneWidget);
    expect(find.text('Easyload'), findsOneWidget);
    expect(find.text('Easycash\nLoan'), findsOneWidget);
    expect(find.text('Savings\nPocket'), findsOneWidget);
    expect(find.text('Invite & Earn'), findsOneWidget);
    expect(find.text('Donations'), findsOneWidget);
    expect(find.text('Term Deposit'), findsOneWidget);
    expect(find.text('Daily Rewards'), findsOneWidget);
    expect(find.text('Buy Now Pay\nLater'), findsOneWidget);
    expect(find.text('Insurance\nMarketplace'), findsOneWidget);
    expect(find.text('M-Tag'), findsOneWidget);
    expect(find.text('Rs.1 Game'), findsOneWidget);
    expect(find.text('See All'), findsOneWidget);

    // 4. Debit Cards and MiniApps
    expect(find.text('Get your easypaisa Debit Card'), findsOneWidget);
    expect(find.text('Online Card'), findsOneWidget);
    expect(find.text('Plastic Card'), findsOneWidget);
    await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text('Discover MiniApps on easypaisa'), findsOneWidget);

    // 5. Image Assets verification
    expect(find.byType(Image), findsWidgets);
  });
}

