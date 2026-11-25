import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/features/auth/presentation/screens/auth_widgets/auth_widgets.dart';
import 'package:fankoush/features/auth/presentation/screens/login_screen.dart';
import 'package:fankoush/features/auth/presentation/screens/register_screen.dart';
import 'package:fankoush/shared/widgets/custom_elevated_button.dart';

void main() {
  testWidgets('Auth widgets compile and render without error', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AuthHeader(title: 'العنوان', subtitle: 'الوصف'),
                  FieldLabel('حقل تجريبي'),
                  CustomElevatedButton(text: 'زر تجريبي', onPressed: null),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('العنوان'), findsOneWidget);
    expect(find.text('الوصف'), findsOneWidget);
    expect(find.text('حقل تجريبي'), findsOneWidget);
    expect(find.text('زر تجريبي'), findsOneWidget);
  });

  testWidgets('LoginScreen compiles and renders', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.text(AppStrings.loginButton), findsWidgets);
    expect(find.text(AppStrings.rememberMe), findsOneWidget);
  });

  testWidgets('RegisterScreen compiles and renders', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => const MaterialApp(home: RegisterScreen()),
      ),
    );

    expect(find.text(AppStrings.registerButton), findsWidgets);
    expect(find.text(AppStrings.countryLabel), findsOneWidget);
  });
}
