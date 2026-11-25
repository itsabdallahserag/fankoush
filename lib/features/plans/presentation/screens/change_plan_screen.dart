import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Choose Your Plan" (اختار باقتك - Screen 3).
/// Matches the right screen in the screenshot:
/// - AppTopBar with Notification on Left, Logo in Center, Profile on Right.
/// - Header: Back chevron button ( > ) on the RIGHT, Title "اختار باقتك" in Center.
/// - Subtitle: "كمّل قفشاتك مع الباقة اللي تناسبك".
/// - Current Plan Card ("باقتك الحالية"):
///   - Top: "باقتك الحالية" on RIGHT, "• نشطة" badge on LEFT.
///   - Bottom: Medal icon, "فانكوش بلس" on RIGHT, "28 محاولة متبقية • تنتهي 15 نوفمبر".
/// - Section Title: "الباقات المتاحة" on the RIGHT.
/// - Selectable Plan Options:
///   1. "فانكوش لايت" (20 محاولة • 30 يوم | 199 جنيه شهرياً)
///   2. "فانكوش بلس" (40 محاولة • 30 يوم | 350 جنيه) - Selected by default
/// - Bottom Sticky:
///   - CTA Button: "متابعة للدفع ←" -> navigates to PaymentMethodScreen with selected PlanModel.
///   - Security Note: "🔒 دفع إلكتروني آمن ومشفر 100%".
class ChangePlanScreen extends StatefulWidget {
  const ChangePlanScreen({super.key});

  @override
  State<ChangePlanScreen> createState() => _ChangePlanScreenState();
}

class _ChangePlanScreenState extends State<ChangePlanScreen> {
  // 0 = فانكوش لايت, 1 = فانكوش بلس (Default selected in screenshot)
  int _selectedIndex = 1;

  final List<PlanModel> _availablePlans = const [
    PlanModel(
      name: 'فانكوش لايت',
      price: 199,
      attempts: 20,
      days: 30,
      footer: 'بحث أسرع وتاريخ كامل',
      validityLabel: 'صالحة لمدة 30 يوم',
    ),
    PlanModel(
      name: 'فانكوش بلس',
      price: 350,
      attempts: 40,
      days: 30,
      footer: 'بحث أسرع و أفيشات اكتر',
      isPopular: true,
      validityLabel: 'صالحة لمدة 30 يوم',
    ),
  ];

  void _onProceedToPayment() {
    final selectedPlan = _availablePlans[_selectedIndex];
    Navigator.pushNamed(
      context,
      AppRoutes.paymentMethod,
      arguments: selectedPlan,
    );
  }

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

                      // Card: "باقتك الحالية"
                      _buildCurrentPlanBox(),

                      22.verticalSpace,

                      // Section Title: "الباقات المتاحة"
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'الباقات المتاحة',
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textHeadingDark,
                          ),
                        ),
                      ),

                      12.verticalSpace,

                      // Plan 1: فانكوش لايت
                      _buildPlanOption(
                        index: 0,
                        title: 'فانكوش لايت',
                        subtitle: '20 محاولة • 30 يوم',
                        price: 199,
                        periodLabel: 'شهرياً',
                      ),

                      12.verticalSpace,

                      // Plan 2: فانكوش بلس
                      _buildPlanOption(
                        index: 1,
                        title: 'فانكوش بلس',
                        subtitle: '40 محاولة • 30 يوم',
                        price: 350,
                      ),

                      24.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Area
              _buildBottomStickyArea(),
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
                'اختار باقتك',
                style: GoogleFonts.cairo(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),
              2.verticalSpace,
              Text(
                'كمّل قفشاتك مع الباقة اللي تناسبك',
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
  // Current Plan Box ("باقتك الحالية")
  // ---------------------------------------------------------------------------
  Widget _buildCurrentPlanBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Column(
        children: [
          // Top Row: "باقتك الحالية" on RIGHT, "• نشطة" on LEFT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'باقتك الحالية',
                style: GoogleFonts.cairo(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF666C7B),
                ),
              ),

              // Active Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F8EE),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      'نشطة',
                      style: GoogleFonts.cairo(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          12.verticalSpace,

          // Bottom Row: Medal icon + Name & validity
          Row(
            children: [
              // Medal Icon container on RIGHT
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEC529),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.iconReward,
                    width: 20.r,
                    height: 20.r,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.emoji_events_rounded,
                      color: const Color(0xFFE59A00),
                      size: 20.sp,
                    ),
                  ),
                ),
              ),

              12.horizontalSpace,

              // Name and validity column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'فانكوش بلس',
                    style: GoogleFonts.cairo(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textHeadingDark,
                    ),
                  ),
                  Text(
                    '28 محاولة متبقية • تنتهي 15 نوفمبر',
                    style: GoogleFonts.cairo(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666C7B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Available Plan Option Item
  // In RTL:
  // - Radio circle & Plan title/subtitle are on the RIGHT
  // - Price & monthly label are on the LEFT
  // ---------------------------------------------------------------------------
  Widget _buildPlanOption({
    required int index,
    required String title,
    required String subtitle,
    required int price,
    String? periodLabel,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFFDF5) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFF5A623)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFF5A623).withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // RIGHT: Radio circle + Plan Info
            Row(
              children: [
                // Radio indicator
                Container(
                  width: 22.r,
                  height: 22.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFF5A623)
                          : const Color(0xFFD1D5DB),
                      width: isSelected ? 5.5 : 1.5,
                    ),
                    color: Colors.white,
                  ),
                ),

                12.horizontalSpace,

                // Plan Title and Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textHeadingDark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.cairo(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666C7B),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // LEFT: Price and Period
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$price',
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? const Color(0xFFE59A00)
                            : AppColors.textHeadingDark,
                      ),
                    ),
                    4.horizontalSpace,
                    Text(
                      'جنيه',
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFFE59A00)
                            : const Color(0xFF666C7B),
                      ),
                    ),
                  ],
                ),
                if (periodLabel != null) ...[
                  Text(
                    periodLabel,
                    style: GoogleFonts.cairo(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Sticky Area: CTA Button + Security Note
  // ---------------------------------------------------------------------------
  Widget _buildBottomStickyArea() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 18.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CTA Button: "متابعة للدفع ←"
          GestureDetector(
            onTap: _onProceedToPayment,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'متابعة للدفع',
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                  8.horizontalSpace,
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.sp,
                    color: const Color(0xFF1B2230),
                  ),
                ],
              ),
            ),
          ),

          10.verticalSpace,

          // Security Note: "🔒 دفع إلكتروني آمن ومشفر 100%"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.iconLock),
              6.horizontalSpace,
              Text(
                'دفع إلكتروني آمن ومشفر 100%',
                style: GoogleFonts.cairo(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF666C7B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
