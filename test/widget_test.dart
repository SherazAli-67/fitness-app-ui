import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App launches on home shell', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.textContaining(StringConst.greetingName), findsOneWidget);
  });
}
