import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:payzen_app/main.dart';
import 'package:payzen_app/screens/main/controller/main_controller.dart';

void main() {
  testWidgets('PayZen app smoke test', (WidgetTester tester) async {
    Get.put(MainController());
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
