import 'package:flutter/material.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/auth/presentation/screens/login_screen.dart';
import 'package:fankoush/features/auth/presentation/screens/register_screen.dart';
import 'package:fankoush/features/home/presentation/screens/main_shell_screen.dart';
import 'package:fankoush/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:fankoush/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/card_payment_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/change_plan_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/discover_plans_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/my_plan_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/out_of_attempts_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/payment_method_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/payment_success_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/plan_checkout_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/plan_details_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/wallet_payment_screen.dart';
import 'package:fankoush/features/profile/presentation/screens/birthday_screen.dart';
import 'package:fankoush/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:fankoush/features/profile/presentation/screens/profile_screen.dart';
import 'package:fankoush/features/recording/presentation/screens/efieh_result_screen.dart';
import 'package:fankoush/features/recording/presentation/screens/finding_efieh_screen.dart';
import 'package:fankoush/features/recording/presentation/screens/record_audio_screen.dart';
import 'package:fankoush/features/recording/presentation/screens/review_audio_screen.dart';
import 'package:fankoush/features/splash/presentation/screens/splash_screen.dart';

/// Centralized router for the Fankoush application.
/// Uses native Flutter MaterialPageRoute for robust, dependency-free navigation.
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashScreen(), settings);

      case AppRoutes.onboarding:
        return _buildRoute(const OnboardingScreen(), settings);

      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);

      case AppRoutes.register:
        return _buildRoute(const RegisterScreen(), settings);

      case AppRoutes.mainShell:
        final initialIndex = settings.arguments as int? ?? 0;
        return _buildRoute(
          MainShellScreen(initialIndex: initialIndex),
          settings,
        );

      case AppRoutes.home:
        return _buildRoute(const MainShellScreen(initialIndex: 0), settings);

      case AppRoutes.recordAudio:
        return _buildRoute(const RecordAudioScreen(), settings);

      case AppRoutes.reviewAudio:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          ReviewAudioScreen(
            duration:
                args?['duration'] as Duration? ?? const Duration(seconds: 12),
            levels: args?['levels'] as List<double>? ?? const [],
            audioPath: args?['audioPath'] as String?,
          ),
          settings,
        );

      case AppRoutes.findingEfieh:
        return _buildRoute(const FindingEfiehScreen(), settings);

      case AppRoutes.efiehResult:
        return _buildRoute(const EfiehResultScreen(), settings);

      case AppRoutes.plans:
        return _buildRoute(const PlansScreen(), settings);

      case AppRoutes.discoverPlans:
        return _buildRoute(const DiscoverPlansScreen(), settings);

      case AppRoutes.planCheckout:
        final plan = settings.arguments as PlanModel?;
        return _buildRoute(PlanCheckoutScreen(plan: plan), settings);

      case AppRoutes.paymentMethod:
        final plan = settings.arguments as PlanModel?;
        return _buildRoute(PaymentMethodScreen(plan: plan), settings);

      case AppRoutes.cardPayment:
        final plan = settings.arguments as PlanModel?;
        return _buildRoute(CardPaymentScreen(plan: plan), settings);

      case AppRoutes.walletPayment:
        final plan = settings.arguments as PlanModel?;
        return _buildRoute(WalletPaymentScreen(plan: plan), settings);

      case AppRoutes.paymentSuccess:
        final plan = settings.arguments as PlanModel?;
        return _buildRoute(PaymentSuccessScreen(plan: plan), settings);

      case AppRoutes.myPlan:
        return _buildRoute(const MyPlanScreen(), settings);

      case AppRoutes.planDetails:
        return _buildRoute(const PlanDetailsScreen(), settings);

      case AppRoutes.changePlan:
        return _buildRoute(const ChangePlanScreen(), settings);

      case AppRoutes.outOfAttempts:
        return _buildRoute(const OutOfAttemptsScreen(), settings);

      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);

      case AppRoutes.editProfile:
        return _buildRoute(const EditProfileScreen(), settings);

      case AppRoutes.birthday:
        return _buildRoute(const BirthdayScreen(), settings);

      case AppRoutes.notifications:
        return _buildRoute(const NotificationsScreen(), settings);

      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute<dynamic>(builder: (_) => page, settings: settings);
  }
}
