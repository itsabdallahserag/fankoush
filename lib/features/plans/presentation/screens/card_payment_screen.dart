import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Enter Card Details" (ادخل بيانات بطاقتك).
/// Perfectly reproduces Screen 3:
/// - AppTopBar with Notification on Left, Logo in Center, Profile on Right.
/// - Header: Back chevron button ( > ) on the RIGHT, Title "ادخل بيانات بطاقتك" in Center.
/// - Subtitle: "كمّل اشتراكك بسهولة وأمان".
/// - Plan Summary Box: Plan name & attempts on RIGHT, Price & "تغيير الباقة" on LEFT.
/// - Card Details Form ("بيانات البطاقة"):
///   1. Card Number ("رقم البطاقة") with card icon on RIGHT, placeholder on LEFT.
///   2. Row with Expiry Date ("تاريخ الانتهاء") & CVV ("الرمز الأمني").
///   3. Cardholder Name ("اسم صاحب البطاقة") with person icon on RIGHT.
/// - Security Guarantee Banner: "دفع آمن ومشفر" with verified shield on RIGHT.
/// - Bottom Sticky:
///   - "الإجمالي المستحق" on RIGHT, "350 جنيه مصري" in golden on LEFT.
///   - Filled Yellow Button: "ادفع الآن 🔒".
///   - Note: "هيتم تأكيد الدفع وتفعيل الباقة فورياً في حسابك.".
class CardPaymentScreen extends StatefulWidget {
  final PlanModel? plan;

  const CardPaymentScreen({super.key, this.plan});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  void _onPay(PlanModel plan) {
    Navigator.pushNamed(context, AppRoutes.paymentSuccess, arguments: plan);
  }

  @override
  Widget build(BuildContext context) {
    final effectivePlan =
        widget.plan ??
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.verticalSpace,

                      // Header Row: Back button ( > ) on the RIGHT, Title centered
                      _buildHeaderWithBack(),

                      4.verticalSpace,

                      // Subtitle: "كمّل اشتراكك بسهولة وأمان"
                      Center(
                        child: Text(
                          'كمّل اشتراكك بسهولة وأمان',
                          style: GoogleFonts.cairo(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666C7B),
                          ),
                        ),
                      ),

                      18.verticalSpace,

                      // Plan Summary Box
                      _buildPlanSummaryCard(effectivePlan),

                      20.verticalSpace,

                      // Card Details Form Section
                      _buildCardFormSection(),

                      16.verticalSpace,

                      // Security Banner ("دفع آمن ومشفر")
                      _buildSecurityBanner(),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Summary & CTA Button ("ادفع الآن 🔒")
              _buildBottomSummaryAndCTA(effectivePlan),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header with Back button on the RIGHT and Title centered
  // ---------------------------------------------------------------------------
  Widget _buildHeaderWithBack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Centered Title: "ادخل بيانات بطاقتك"
        Center(
          child: Text(
            'ادخل بيانات بطاقتك',
            style: GoogleFonts.cairo(
              fontSize: 21.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeadingDark,
            ),
          ),
        ),

        // Back Button on the RIGHT (in RTL right: 0)
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () => Navigator.maybePop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 32.r,
              height: 32.r,
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
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Plan Summary Box
  // ---------------------------------------------------------------------------
  Widget _buildPlanSummaryCard(PlanModel plan) {
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
          // RIGHT in RTL: Plan Name & Attempts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
              2.verticalSpace,
              Text(
                '${plan.attempts} محاولة • ${plan.days} يوم',
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8C93A0),
                ),
              ),
            ],
          ),

          // LEFT in RTL: Price & "تغيير الباقة"
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${plan.price} جنيه',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
              2.verticalSpace,
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'تغيير الباقة',
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2F80ED),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card Details Form Section ("بيانات البطاقة")
  // ---------------------------------------------------------------------------
  Widget _buildCardFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row: Card icon on RIGHT, "بيانات البطاقة" next to it
        Row(
          children: [
            Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E6),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Center(
                child: Image.asset(
                  AppImages.iconBank,
                  width: 14.w,
                  height: 14.h,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.credit_card_rounded,
                    size: 14,
                    color: Color(0xFFF5A623),
                  ),
                ),
              ),
            ),
            8.horizontalSpace,
            Text(
              'بيانات البطاقة',
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1B2230),
              ),
            ),
          ],
        ),

        14.verticalSpace,

        // Field 1: Card Number ("رقم البطاقة")
        Text(
          'رقم البطاقة',
          style: GoogleFonts.cairo(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1B2230),
          ),
        ),
        6.verticalSpace,
        Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder on Left (in RTL text appears on start/right or spaceBetween)
              Icon(
                Icons.credit_card_outlined,
                size: 20.sp,
                color: const Color(0xFF9CA3AF),
              ),
              Text(
                '1234 5678 9012 3456',
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 1.1,
                ),
              ),

              // Card Icon on Right (in RTL child 1 appears on left)
            ],
          ),
        ),

        12.verticalSpace,

        // Row with Expiry Date & CVV
        Row(
          children: [
            // Field 2: Expiry Date ("تاريخ الانتهاء") on the RIGHT in RTL
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاريخ الانتهاء',
                    style: GoogleFonts.cairo(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                  6.verticalSpace,
                  Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 18.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                        Text(
                          'MM/YY',
                          style: GoogleFonts.cairo(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            12.horizontalSpace,

            // Field 3: Security Code ("الرمز الأمني" / "CVV") on the LEFT in RTL
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CVV',
                        style: GoogleFonts.cairo(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8C93A0),
                        ),
                      ),
                      Text(
                        'الرمز الأمني',
                        style: GoogleFonts.cairo(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1B2230),
                        ),
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '•••',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF9CA3AF),
                            letterSpacing: 2,
                          ),
                        ),
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 18.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        12.verticalSpace,

        // Field 4: Cardholder Name ("اسم صاحب البطاقة")
        Text(
          'اسم صاحب البطاقة',
          style: GoogleFonts.cairo(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1B2230),
          ),
        ),
        6.verticalSpace,
        Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 20.sp,
                color: const Color(0xFF9CA3AF),
              ),
              Text(
                'AHMED MOHAMED',
                style: GoogleFonts.cairo(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Security Banner ("دفع آمن ومشفر")
  // ---------------------------------------------------------------------------
  Widget _buildSecurityBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1),
      ),
      child: Row(
        children: [
          // Verified Shield on RIGHT in RTL
          Icon(
            Icons.verified_user_outlined,
            size: 20.sp,
            color: const Color(0xFF10B981),
          ),

          10.horizontalSpace,

          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'دفع آمن ومشفر',
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2230),
                  ),
                ),
                2.verticalSpace,
                Text(
                  'نستخدم أعلى معايير الأمان لحماية بياناتك',
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF666C7B),
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
  // Bottom Sticky Summary & CTA ("ادفع الآن 🔒")
  // ---------------------------------------------------------------------------
  Widget _buildBottomSummaryAndCTA(PlanModel plan) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Due Row: "الإجمالي المستحق" on RIGHT, "350 جنيه مصري" in golden on LEFT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'الإجمالي المستحق',
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1B2230),
                ),
              ),
              Text(
                '${plan.price} جنيه مصري',
                style: GoogleFonts.cairo(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF5A623),
                ),
              ),
            ],
          ),

          12.verticalSpace,

          // Primary Button: "ادفع الآن 🔒"
          GestureDetector(
            onTap: () => _onPay(plan),
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
                  Icon(Icons.lock_rounded, size: 18.sp),
                  8.horizontalSpace,

                  Text(
                    'ادفع الآن',
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

          8.verticalSpace,

          // Note below button
          Text(
            'هيتم تأكيد الدفع وتفعيل الباقة فورياً في حسابك.',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8C93A0),
            ),
          ),
        ],
      ),
    );
  }
}
