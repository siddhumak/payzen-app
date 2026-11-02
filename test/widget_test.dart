import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:payzen_app/main.dart';
import 'package:payzen_app/routes/app_routes.dart';
import 'package:payzen_app/screens/main/controller/main_controller.dart';
import 'package:payzen_app/screens/wallet/wallet_add_money_screen.dart';
import 'package:payzen_app/screens/wallet/pan_verification_screen.dart';

void main() {
  testWidgets('PayZen app smoke test', (WidgetTester tester) async {
    Get.put(MainController());
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });

  testWidgets('PAN verification form fits and validates on a phone screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        getPages: AppRoutes.routes,
        initialRoute: AppRoutes.walletActivation,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Proceed to Activation'));
    await tester.pumpAndSettle();

    expect(find.text('Activate PayZen Wallet'), findsOneWidget);
    expect(find.text('PAN Card Number'), findsOneWidget);
    expect(find.text('Full Name (as per PAN)'), findsOneWidget);
    expect(find.text('Date of Birth (as per PAN)'), findsOneWidget);
    await tester.ensureVisible(find.text('Verify PAN Details'));
    await tester.tap(find.text('Verify PAN Details'));
    await tester.pumpAndSettle();

    expect(find.text('Enter your PAN number'), findsOneWidget);
    expect(find.text('Enter your name as printed on your PAN'), findsOneWidget);
    expect(find.text('Select your date of birth'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('PAN verification uses the available phone screen height', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 692);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(home: PanVerificationScreen()),
    );
    await tester.pumpAndSettle();

    final buttonRect = tester.getRect(find.text('Verify PAN Details'));
    expect(buttonRect.bottom, greaterThan(650));
    expect(buttonRect.bottom, lessThanOrEqualTo(692));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Add Money screen displays the wallet artwork', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: WalletAddMoneyScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    final amountField = tester.widget<TextField>(find.byType(TextField));
    expect(amountField.decoration?.prefixText, '₹ ');
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/add_money_wallet.png',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
