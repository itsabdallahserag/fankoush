import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/utils/attempts_tracker.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Payment Success" (عاش يا نجم! 🎉).
/// Matches the right screen in the screenshot:
/// - AppTopBar with Notification on Left, Logo in Center, Profile on Right.
/// - Celebration actor character illustration (3ash.png).
/// - Headline: "عاش يا نجم! 🎉" with reward icon.
/// - Subtitle: "الدفع تم بنجاح، وباقتك اتفعّلت. جاهز نكمّل ؟".
/// - Subscription Details Card ("تفاصيل اشتراكك"):
///   1. "الباقة" with icon_baqa_deatail -> "فانكوش بلس"
///   2. "المحاولات" with icon_more_tries -> "40 محاولة"
///   3. "المدة" with icon_date_deadline -> "30 يوم"
///   4. "المبلغ المدفوع" with icon_paid_money -> "350 جنيه"
/// - Bottom Sticky Actions:
///   1. Primary Yellow Button: "يلا نكمّل قفشات!" -> returns to Home with renewed attempts.
///   2. Secondary Text Button: "عرض اشتراكي".
class PaymentSuccessScreen extends StatelessWidget {
  final PlanModel? plan;

  const PaymentSuccessScreen({super.key, this.plan});

  @override
  Widget build(BuildContext context) {
    final effectivePlan =
        plan ??
        const PlanModel(
          name: 'فانكوش بلس',
          price: 350,
          attempts: 40,
          days: 30,
          footer: 'بحث أسرع و افيهات اكثر',
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with Profile on Right, Logo in Center, Notification on Left
              AppTopBar(
                showBack: false,
                onProfileTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onNotificationTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      6.verticalSpace,

                      // Celebration Illustration (3ash.png)
                      Image.asset(
                        AppImages.successCelebration,
                        width: 210.w,
                        height: 200.h,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.celebration_rounded,
                          size: 100,
                          color: Color(0xFFF5A623),
                        ),
                      ),

                      10.verticalSpace,

                      // Headline: "عاش يا نجم! 🎉"
                      Text(
                        'عاش يا نجم! 🎉',
                        style: GoogleFonts.cairo(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1B2230),
                        ),
                      ),

                      4.verticalSpace,

                      // Subtitle
                      Text(
                        'الدفع تم بنجاح، وباقتك اتفعّلت.\nجاهز نكمّل ؟',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666C7B),
                          height: 1.45,
                        ),
                      ),

                      18.verticalSpace,

                      // Subscription Details Card ("تفاصيل اشتراكك")
                      _buildDetailsCard(effectivePlan),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Actions
              _buildBottomActions(context, effectivePlan),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Subscription Details Card ("تفاصيل اشتراكك")
  // ---------------------------------------------------------------------------
  Widget _buildDetailsCard(PlanModel plan) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title: "تفاصيل اشتراكك"
          Text(
            'تفاصيل اشتراكك',
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1B2230),
            ),
          ),

          14.verticalSpace,

          // Row 1: Plan ("الباقة")
          _buildDetailRow(label: 'الباقة', value: plan.name),

          12.verticalSpace,

          // Row 2: Attempts ("المحاولات")
          _buildDetailRow(label: 'المحاولات', value: '${plan.attempts} محاولة'),

          12.verticalSpace,

          // Row 3: Duration ("المدة")
          _buildDetailRow(label: 'المدة', value: '${plan.days} يوم'),

          12.verticalSpace,

          // Row 4: Paid Amount ("المبلغ المدفوع")
          _buildDetailRow(
            label: 'المبلغ المدفوع',
            value: '${plan.price} جنيه',
            isBoldValue: true,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Single Detail Row
  // ---------------------------------------------------------------------------
  Widget _buildDetailRow({
    required String label,
    required String value,
    bool isBoldValue = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // RIGHT in RTL: Icon + Label
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF666C7B),
              ),
            ),
          ],
        ),

        // LEFT in RTL: Value
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: isBoldValue ? 14.5.sp : 13.5.sp,
            fontWeight: isBoldValue ? FontWeight.w800 : FontWeight.w700,
            color: const Color(0xFF1B2230),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Sticky Actions
  // ---------------------------------------------------------------------------
  Widget _buildBottomActions(BuildContext context, PlanModel plan) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary CTA Button: "يلا نكمّل قفشات!"
          GestureDetector(
            onTap: () {
              // Renew attempts to chosen plan
              AttemptsTracker.attemptsNotifier.value = plan.attempts;
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.mainShell,
                (route) => false,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(26.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'يلا نكمّل قفشات!',
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2230),
                  ),
                ),
              ),
            ),
          ),

          12.verticalSpace,

          // Secondary Action: "عرض اشتراكي"
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.mainShell,
                (route) => false,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Text(
              'عرض اشتراكي',
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1B2230),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
