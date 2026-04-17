import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:farma_facil/main.dart';

void main() {
  testWidgets('App loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FarmaFacilApp()));
    expect(find.text('FarmaFacil'), findsOneWidget);
  });
}