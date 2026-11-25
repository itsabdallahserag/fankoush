import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_router.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FankoushApp());
}

class FankoushApp extends StatelessWidget {
  const FankoushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
