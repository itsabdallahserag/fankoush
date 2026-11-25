import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/features/home/presentation/screens/main_shell_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/features/recording/presentation/screens/record_audio_screen.dart';
import 'package:fankoush/features/recording/presentation/screens/review_audio_screen.dart';
import 'package:fankoush/shared/widgets/mic_permission_dialog.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp(home: child),
    );
  }

  testWidgets('Screen 1: PlansScreen renders correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget(const PlansScreen()));
    expect(find.text(AppStrings.plansTitle), findsOneWidget);
    expect(find.text(AppStrings.planLite), findsOneWidget);
    expect(find.text(AppStrings.planPlus), findsOneWidget);
    expect(find.text(AppStrings.planPro), findsOneWidget);
  });

  testWidgets('Screen 2: HomeScreen and MainShellScreen render correctly', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(const MainShellScreen()));
    expect(find.text(AppStrings.navHome), findsOneWidget);
    expect(find.text(AppStrings.pressToStartRecording), findsOneWidget);
    expect(find.text('3 ${AppStrings.attempts}'), findsOneWidget);
  });

  testWidgets('Screen 3: MicPermissionDialog renders correctly', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showMicPermissionDialog(context),
            child: const Text('open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.micPermissionTitle), findsOneWidget);
    expect(find.text(AppStrings.allow), findsOneWidget);
    expect(find.text(AppStrings.notNow), findsOneWidget);
  });

  testWidgets('Screen 4: RecordAudioScreen renders correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget(const RecordAudioScreen()));
    expect(find.text(AppStrings.recordTitle), findsOneWidget);
    expect(find.text(AppStrings.pressToEndRecording), findsOneWidget);
  });

  testWidgets('Screen 5: ReviewAudioScreen renders correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget(const ReviewAudioScreen()));
    expect(find.text(AppStrings.yourRecording), findsOneWidget);
    expect(find.text(AppStrings.reRecord), findsOneWidget);
    expect(find.text(AppStrings.deleteRecording), findsOneWidget);
    expect(find.text(AppStrings.findEfieh), findsOneWidget);
  });
}
