import 'package:flutter_test/flutter_test.dart';

import 'package:tsaphah_ministries/main.dart';

void main() {
  testWidgets('Home page renders the hero title', (WidgetTester tester) async {
    await tester.pumpWidget(const TsaphahMinistriesApp());

    expect(find.text('Called to Watch, Hear, and Proclaim'), findsOneWidget);
  });
}
