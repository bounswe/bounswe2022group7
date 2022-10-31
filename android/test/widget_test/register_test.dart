import 'package:android/pages/pages.dart';
import 'package:android/providers/register_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../test_utils.dart';

void main() {
  testWidgets('Input fields are correct', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(appWidget(const Register(), [
      ChangeNotifierProvider(create: (_) => RegisterProvider())
    ]));

    // test input fields
    expect(find.text('User Type'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Name (optional)'), findsOneWidget);
    expect(find.text('Surname (optional)'), findsOneWidget);
    expect(find.text('Age (optional)'), findsOneWidget);
    expect(find.text('Country (optional)'), findsOneWidget);

    // test register button
    expect(find.text('Register'), findsOneWidget);

    // test back to login button
    expect(find.text('Have an account? '), findsOneWidget);
    expect(find.text('Back to login page.'), findsOneWidget);
  });
}
