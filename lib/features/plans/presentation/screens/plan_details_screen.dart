import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Plan Details" (تفاصيل الباقة - Screen 2).
/// Matches the middle screen in the screenshot:
/// - AppTopBar with Notification on Left, Logo in Center, Profile on Right.
/// - Header: Back chevron button ( > ) on the RIGHT, Title "تفاصيل الباقة" in Center.
/// - Subtitle: "كل حاجة عن اشتراكك الحالي".
/// - Plan Header Box: "فانكوش بلس" on RIGHT, "• نشطة" status badge on LEFT.
/// - Attempts Box: "رصيد محاولاتك ⚡" with "28 محاولة متبقية من 40", 70% progress bar.
/// - Detailed Info Card: Activation date, expiration date, duration, and paid amount.
/// - Bottom Sticky Button: "تجديد أو تغيير الباقة 🔄" -> navigates to ChangePlanScreen.
class PlanDetailsScreen extends StatelessWidget {
  const PlanDetailsScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.verticalSpace,

                      // Header Row: Back button ( > ) on the RIGHT, Title and Subtitle aligned together
                      _buildHeaderWithBack(context),

                      18.verticalSpace,

                      // Plan Header Box with "• نشطة"
                      _buildPlanHeaderBox(),

                      14.verticalSpace,

                      // Attempts Balance Box ("رصيد محاولاتك ⚡")
                      _buildAttemptsBalanceBox(),

                      14.verticalSpace,

                      // Detailed Info List Card
                      _buildDetailedInfoCard(),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Button: "تجديد أو تغيير الباقة 🔄"
              _buildBottomButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header with Back button on the RIGHT, Title and Subtitle aligned together
  // ---------------------------------------------------------------------------
  Widget _buildHeaderWithBack(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 13.sp,
                color: const Color(0xFF1B2230),
              ),
            ),
          ),
        ),
        12.horizontalSpace,
        // Title and Subtitle Column (same starting alignment)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تفاصيل الباقة',
                style: GoogleFonts.cairo(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),
              2.verticalSpace,
              Text(
                'كل حاجة عن اشتراكك الحالي',
                style: GoogleFonts.cairo(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF666C7B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Plan Header Box with "• نشطة"
  // ---------------------------------------------------------------------------
  Widget _buildPlanHeaderBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Row(
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

          // LEFT in RTL: "• نشطة" Green Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8FAF4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0A9E77),
                  ),
                ),
                6.horizontalSpace,
                Text(
                  'نشطة',
                  style: GoogleFonts.cairo(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0A9E77),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Attempts Balance Box ("رصيد محاولاتك ⚡")
  // ---------------------------------------------------------------------------
  Widget _buildAttemptsBalanceBox() {
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
          // Header: "رصيد محاولاتك ⚡"
          Row(
            children: [
              Text(
                '⚡   رصيد محاولاتك',
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
            ],
          ),

          10.verticalSpace,

          // Count & Percentage Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Count: "28 محاولة متبقية من 40"
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '28',
                    style: GoogleFonts.cairo(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2F80ED),
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    'محاولة متبقية من 40',
                    style: GoogleFonts.cairo(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF666C7B),
                    ),
                  ),
                ],
              ),

              // "70%"
              Text(
                '70%',
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2F80ED),
                ),
              ),
            ],
          ),

          10.verticalSpace,

          // Progress Bar
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

          10.verticalSpace,

          // Subtext: "ⓘ استخدم محاولاتك قبل انتهاء الباقة."
          Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: Color(0xFF8C93A0),
              ),
              4.horizontalSpace,
              Text(
                'استخدم محاولاتك قبل انتهاء الباقة.',
                style: GoogleFonts.cairo(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8C93A0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Detailed Info List Card
  // ---------------------------------------------------------------------------
  Widget _buildDetailedInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Column(
        children: [
          // Row 1: Activation Date
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'تاريخ التفعيل',
            value: '15 أكتوبر 2026',
          ),

          12.verticalSpace,

          // Row 2: Expiry Date
          _buildInfoRow(
            icon: Icons.access_time_rounded,
            label: 'تاريخ الانتهاء',
            value: '14 نوفمبر 2026',
          ),

          12.verticalSpace,

          // Row 3: Plan Duration
          _buildInfoRow(
            icon: Icons.hourglass_empty_rounded,
            label: 'مدة الباقة',
            value: '30 يوم',
          ),

          12.verticalSpace,

          // Row 4: Paid Amount
          _buildInfoRow(
            icon: Icons.receipt_long_outlined,
            label: 'المبلغ المدفوع',
            value: '350 جنيه',
            isBoldValue: true,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Single Info Row
  // ---------------------------------------------------------------------------
  Widget _buildInfoRow({
    required IconData icon,
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
            Icon(icon, size: 16.sp, color: const Color(0xFF807660)),
            8.horizontalSpace,
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1B1C1C),
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
            color: const Color(0xFF1B1C1C),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Sticky Button: "تجديد أو تغيير الباقة 🔄"
  // ---------------------------------------------------------------------------
  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.changePlan);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.autorenew_rounded,
                size: 20.sp,
                color: const Color(0xFF1B2230),
              ),
              8.horizontalSpace,

              Text(
                'تجديد أو تغيير الباقة',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
