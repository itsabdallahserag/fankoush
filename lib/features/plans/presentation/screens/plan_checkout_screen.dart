import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing the Plan Review / Confirmation (راجع باقتك! 🎬).
/// Perfectly reproduces the right screenshot:
/// - AppTopBar with Profile, Logo, and Notification bell
/// - "🎟 تأكيد الاشتراك" pill badge
/// - Centered headline "راجع باقتك! 🎬" and subtitle
/// - Selected Plan Card with "★ الأكثر اختيارًا", "تغيير الباقة ←", details box
/// - "ملخص الطلب" section with items, price breakdown, and total
/// - "دفع آمن ومشفر 100%" security guarantee card with iconLock
/// - Sticky Bottom CTA: "متابعة للدفع – 350 جنيه" and confirmation note
class PlanCheckoutScreen extends StatelessWidget {
  final PlanModel? plan;

  const PlanCheckoutScreen({super.key, this.plan});

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
          isPopular: true,
          isPopcornIcon: true,
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Standard Top Bar
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

                      // "🎟 تأكيد الاشتراك" badge
                      _buildSubscriptionPill(),

                      10.verticalSpace,

                      // Title: "راجع باقتك! 🎬"
                      _buildTitle(),

                      6.verticalSpace,

                      // Subtitle
                      Text(
                        'خطوة واحدة وتكمّل رحلة الإفيهات.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666C7B),
                        ),
                      ),

                      18.verticalSpace,

                      // Selected Plan Card
                      _buildPlanCard(context, effectivePlan),

                      16.verticalSpace,

                      // Order Summary ("ملخص الطلب")
                      _buildOrderSummary(effectivePlan),

                      14.verticalSpace,

                      // Security / Guarantee Card
                      _buildSecurityBox(),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky CTA & Note
              _buildBottomAction(context, effectivePlan),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Subscription Badge: "🎟 تأكيد الاشتراك"
  // ---------------------------------------------------------------------------
  Widget _buildSubscriptionPill() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFE0A0), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.iconVerify),
          6.horizontalSpace,
          Text(
            'تأكيد الاشتراك',
            style: GoogleFonts.cairo(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFC48600),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Screen Title
  // ---------------------------------------------------------------------------
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'راجع باقتك!',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textHeadingDark,
          ),
        ),
        6.horizontalSpace,
        Text('🎬', style: TextStyle(fontSize: 20.sp)),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Selected Plan Card
  // ---------------------------------------------------------------------------
  Widget _buildPlanCard(BuildContext context, PlanModel plan) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Row: "★ الأكثر اختيارًا" badge on Right, "تغيير الباقة ←" on Left
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge
              if (plan.isPopular)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'الأكثر اختيارًا',
                        style: GoogleFonts.cairo(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1B2230),
                        ),
                      ),
                      4.horizontalSpace,

                      Image.asset(
                        AppImages.iconStar,
                        width: 12.w,
                        height: 12.h,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.star_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox.shrink(),

              // "تغيير الباقة ←"
              GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'تغيير الباقة',
                      style: GoogleFonts.cairo(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2F80ED),
                      ),
                    ),
                    4.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.sp,
                      color: const Color(0xFF2F80ED),
                    ),
                  ],
                ),
              ),
            ],
          ),

          12.verticalSpace,

          // Middle: Plan Name & Subtitle on Right, Price on Left
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textHeadingDark,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    'الاشتراك الشهري المميز',
                    style: GoogleFonts.cairo(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8C93A0),
                    ),
                  ),
                ],
              ),

              // Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${plan.price}',
                    style: GoogleFonts.cairo(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF5A623),
                    ),
                  ),
                  4.horizontalSpace,
                  Text(
                    'جنيه',
                    style: GoogleFonts.cairo(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF5A623),
                    ),
                  ),
                ],
              ),
            ],
          ),

          14.verticalSpace,

          // Inner Details Box (Attempts & Validity)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFF0EFEA), width: 1),
            ),
            child: Column(
              children: [
                // Feature 1: Attempts
                Row(
                  children: [
                    Icon(
                      Icons.mic_none_rounded,
                      size: 16.sp,
                      color: const Color(0xFFF5A623),
                    ),
                    8.horizontalSpace,
                    Text(
                      '${plan.attempts} محاولة صوتية للتعرف على الإفيه',
                      style: GoogleFonts.cairo(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D3139),
                      ),
                    ),
                  ],
                ),

                10.verticalSpace,

                // Feature 2: Validity
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 16.sp,
                      color: const Color(0xFFF5A623),
                    ),
                    8.horizontalSpace,
                    Text(
                      'صالحة لمدة ${plan.days} يومًا',
                      style: GoogleFonts.cairo(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D3139),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Order Summary: "ملخص الطلب"
  // ---------------------------------------------------------------------------
  Widget _buildOrderSummary(PlanModel plan) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            children: [
              Text(
                'ملخص الطلب',
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),
              Spacer(),
              Image.asset(
                AppImages.iconSummary,
                width: 18.w,
                height: 18.h,
                errorBuilder: (_, _, _) => Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F2F4),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    size: 14.sp,
                    color: const Color(0xFF666C7B),
                  ),
                ),
              ),
            ],
          ),

          14.verticalSpace,

          // Row 1: Plan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الباقة',
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF666C7B),
                ),
              ),
              Text(
                plan.name,
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeadingDark,
                ),
              ),
            ],
          ),

          10.verticalSpace,

          // Row 2: Base Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'السعر الأساسي',
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF666C7B),
                ),
              ),
              Text(
                '${plan.price} جنيه',
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeadingDark,
                ),
              ),
            ],
          ),

          12.verticalSpace,

          // Divider
          Container(height: 1, color: const Color(0xFFF0EFEA)),

          12.verticalSpace,

          // Row 3: Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الإجمالي',
                    style: GoogleFonts.cairo(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textHeadingDark,
                    ),
                  ),
                  Text(
                    'شامل الضريبة وكافة المزايا',
                    style: GoogleFonts.cairo(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8C93A0),
                    ),
                  ),
                ],
              ),
              Text(
                '${plan.price} جنيه',
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Security Guarantee Box: "دفع آمن ومشفر 100%"
  // ---------------------------------------------------------------------------
  Widget _buildSecurityBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFFFEDB8), width: 1),
      ),
      child: Row(
        children: [
          // Icon Lock on Right
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE8B2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Image.asset(
                AppImages.iconLock,
                width: 20.w,
                height: 20.h,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.lock_rounded,
                  size: 20,
                  color: Color(0xFFB78103),
                ),
              ),
            ),
          ),

          12.horizontalSpace,

          // Text Column on Left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'دفع آمن ومشفر 100%',
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2230),
                  ),
                ),
                2.verticalSpace,
                Text(
                  'تأكيد فوري دون انتظار ومتابعة فورية لإفيهاتك المفضلة',
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
  // Bottom Sticky Action Button: "متابعة للدفع – 350 جنيه"
  // ---------------------------------------------------------------------------
  Widget _buildBottomAction(BuildContext context, PlanModel plan) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.paymentMethod,
                arguments: plan,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'متابعة للدفع – ${plan.price} جنيه',
                    style: GoogleFonts.cairo(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                  8.horizontalSpace,

                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 20.sp,
                    color: const Color(0xFF1B2230),
                  ),
                ],
              ),
            ),
          ),

          8.verticalSpace,

          Text(
            'هيتم تفعيل باقتك بعد تأكيد الدفع بنجاح.',
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
