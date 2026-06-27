import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:grade_tracker_app/main.dart';
import 'package:grade_tracker_app/providers/subject_provider.dart';
import 'package:grade_tracker_app/providers/theme_provider.dart';

void main() {
  testWidgets('App smoke test — renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SubjectProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const GradeTrackerApp(),
      ),
    );
    // Verify that the Add Subject tab title is shown.
    expect(find.text('Add Subject'), findsWidgets);
  });
}
