import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_example/main.dart' as app;
import 'package:testing_example/main.dart';
import 'package:testing_example/screens.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test App Testing', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    const int waitTimeSmall = 5; //seconds
    const int waitTimeLong = 11; //seconds

    testWidgets('Screens test1', (widgetTester) async {
      app.main();

      await widgetTester.pumpWidget(MyApp());
      await widgetTester.pumpAndSettle();

      // await Future.delayed(Duration(seconds: waitTimeLong));

      Finder emailField = find.byType(TextField).first;
      await widgetTester.enterText(emailField, 'shafqat@gmail.com');
      await widgetTester.pumpAndSettle();
      expect(find.text('shafqat@gmail.com'), findsOneWidget);

      Finder loginBtn = find.byType(ElevatedButton).first;
      await widgetTester.tap(loginBtn);
      await widgetTester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(VerifyOTPScreen), findsOneWidget);

      await widgetTester.pump(const Duration(seconds: 10));
      // await Future.delayed(const Duration(seconds: 10));

      Finder verifyButton = find.byType(ElevatedButton).first;
      await widgetTester.tap(verifyButton);
      await widgetTester.pumpAndSettle();
      expect(find.byType(VerifyOTPScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      await Future.delayed(const Duration(seconds: 10));
    });
  });
}
