import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "My Plan" (باقتي - Screen 1).
/// Matches the left screen in the screenshot:
/// - AppTopBar with Notification on Left, Logo in Center, Profile on Right.
/// - Centered Title: "باقتي", Subtitle: "كل تفاصيل اشتراكك مع فانكوش".
/// - Card 1: Current plan "فانكوش بلس" with "الباقة الحالية" badge, end date and paid amount.
/// - Card 2: Remaining Attempts ("المحاولات المتبقية ⚡") with 28/40 count, 70% progress bar.
/// - Action Tile 1: "تفاصيل الباقة" -> navigates to PlanDetailsScreen.
/// - Action Tile 2: "تجديد أو تغيير الباقة" -> navigates to ChangePlanScreen.
/// - Banner: "محتاج محاولات أكثر؟" with "شوف الباقات" button -> navigates to DiscoverPlansScreen.
class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                      // Title: "باقتي"
                      Text(
                        'باقتي',
                        style: GoogleFonts.cairo(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textHeadingDark,
                        ),
                      ),

                      2.verticalSpace,

                      // Subtitle
                      Text(
                        'كل تفاصيل اشتراكك مع فانكوش',
                        style: GoogleFonts.cairo(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666C7B),
                        ),
                      ),

                      18.verticalSpace,

                      // Card 1: Current Plan Card
                      _buildCurrentPlanCard(context),

                      14.verticalSpace,

                      // Card 2: Remaining Attempts ("المحاولات المتبقية ⚡")
                      _buildRemainingAttemptsCard(),

                      14.verticalSpace,

                      // Action Tile 1: "تفاصيل الباقة"
                      _buildActionTile(
                        iconBgColor: const Color(0xFFEBF3FF),
                        iconColor: const Color(0xFF2F80ED),
                        iconData: Icons.description_outlined,
                        title: 'تفاصيل الباقة',
                        subtitle: 'عرض كل تفاصيل اشتراكك',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.planDetails),
                      ),

                      10.verticalSpace,

                      // Action Tile 2: "تجديد أو تغيير الباقة"
                      _buildActionTile(
                        iconBgColor: const Color(0xFFFFF0F0),
                        iconColor: const Color(0xFFEF4444),
                        iconData: Icons.autorenew_rounded,
                        title: 'تجديد أو تغيير الباقة',
                        subtitle: 'اختار باقة جديدة أو جدّد اشتراكك',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.changePlan),
                      ),

                      14.verticalSpace,

                      // Banner: "محتاج محاولات أكثر؟"
                      _buildMoreAttemptsBanner(context),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card 1: Current Plan Card
  // ---------------------------------------------------------------------------
  Widget _buildCurrentPlanCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Plan Name & Attempts on RIGHT, "الباقة الحالية" on LEFT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // RIGHT in RTL: Icon + Name
              Row(
                children: [
                  Container(
                    width: 38.r,
                    height: 38.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEC529),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Image.asset(
                        AppImages.iconReward,
                        width: 20.w,
                        height: 20.h,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.workspace_premium_rounded,
                          size: 20,
                          color: Color(0xFF5C3D00),
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'فانكوش بلس',
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1B2230),
                        ),
                      ),
                      2.verticalSpace,
                      Text(
                        '40 محاولة • 30 يوم',
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C93A0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // LEFT in RTL: "الباقة الحالية" Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDF95),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFFFEDB8), width: 1),
                ),
                child: Text(
                  'الباقة الحالية',
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF594400),
                  ),
                ),
              ),
            ],
          ),

          14.verticalSpace,

          // Divider
          Container(height: 1, color: const Color(0xFFF0EFEA)),

          12.verticalSpace,

          // Bottom Two Stats: "المبلغ المدفوع" on LEFT, "تاريخ الانتهاء" on RIGHT
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF6F3F2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المبلغ المدفوع',
                        style: GoogleFonts.cairo(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C93A0),
                        ),
                      ),
                      3.verticalSpace,
                      Row(
                        children: [
                          Image.asset(
                            AppImages.iconPaidMoney,
                            width: 14.w,
                            height: 14.h,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.payments_outlined,
                              size: 14,
                              color: Color(0xFFF5A623),
                            ),
                          ),
                          6.horizontalSpace,

                          Text(
                            '350 ج.م',
                            style: GoogleFonts.cairo(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1B2230),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              8.horizontalSpace,

              // RIGHT in RTL: Expiry Date
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF6F3F2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تاريخ الانتهاء',
                        style: GoogleFonts.cairo(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C93A0),
                        ),
                      ),
                      3.verticalSpace,
                      Row(
                        children: [
                          Image.asset(
                            AppImages.iconDateDeadline,
                            width: 14.w,
                            height: 14.h,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.calendar_month_outlined,
                              size: 14,
                              color: Color(0xFF1B2230),
                            ),
                          ),
                          6.horizontalSpace,
                          Text(
                            '15 نوفمبر 2026',
                            style: GoogleFonts.cairo(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1B2230),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // LEFT in RTL: Paid Amount
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card 2: Remaining Attempts ("المحاولات المتبقية ⚡")
  // ---------------------------------------------------------------------------
  Widget _buildRemainingAttemptsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: "المحاولات المتبقية ⚡" on the RIGHT
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFDF95),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  size: 16.sp,
                  color: const Color(0xFF815600),
                ),
              ),
              6.horizontalSpace,

              Text(
                'المحاولات المتبقية',
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
            ],
          ),

          10.verticalSpace,

          // Count: "28 من 40 محاولة"
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '28 ',
                  style: GoogleFonts.cairo(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF2F80ED),
                  ),
                ),
                TextSpan(
                  text: 'من 40 محاولة',
                  style: GoogleFonts.cairo(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1B2230),
                  ),
                ),
              ],
            ),
          ),

          10.verticalSpace,

          // Progress Bar (70% filled)
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 8.h,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Container(
                    height: 8.h,
                    width: constraints.maxWidth * 0.7,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F80ED),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              );
            },
          ),

          8.verticalSpace,

          // Subtext Row: Info on RIGHT, "70% متبقي" on LEFT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'استخدم محاولاتك قبل انتهاء الباقة.',
                style: GoogleFonts.cairo(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8C93A0),
                ),
              ),
              Text(
                '70% متبقي',
                style: GoogleFonts.cairo(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2F80ED),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Action Tile Item
  // ---------------------------------------------------------------------------
  Widget _buildActionTile({
    required Color iconBgColor,
    required Color iconColor,
    required IconData iconData,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        ),
        child: Row(
          children: [
            // RIGHT in RTL: Icon Box
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Icon(iconData, size: 20.sp, color: iconColor),
              ),
            ),

            12.horizontalSpace,

            // MIDDLE in RTL: Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    subtitle,
                    style: GoogleFonts.cairo(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8C93A0),
                    ),
                  ),
                ],
              ),
            ),

            // LEFT in RTL: Chevron
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 13.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Banner: "محتاج محاولات أكثر؟"
  // ---------------------------------------------------------------------------
  Widget _buildMoreAttemptsBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // RIGHT in RTL: Bulb Icon
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDF95),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.lightbulb_sharp,
                size: 18.sp,
                color: const Color(0xFF815600),
              ),
            ),
          ),

          10.horizontalSpace,

          // MIDDLE in RTL: Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'محتاج محاولات أكثر؟',
                  style: GoogleFonts.cairo(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2230),
                  ),
                ),
                2.verticalSpace,
                Text(
                  'اكتشف باقي باقات فانكوش واختار الأنسب ليك',
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8C93A0),
                  ),
                ),
              ],
            ),
          ),

          10.horizontalSpace,

          // LEFT in RTL: "شوف الباقات" Button
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.discoverPlans);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: const Color(0xFF399CFE),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'شوف الباقات',
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
