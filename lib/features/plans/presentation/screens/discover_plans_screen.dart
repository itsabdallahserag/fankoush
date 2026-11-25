import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Choose Your Plan and Keep Laughing" (اختار باقتك وكمّل الضحك! 🎬).
/// Opened when user clicks "Discover Plans" (اكتشف الباقات) from:
/// 1. "القفشات ببلاش خلصت!" (OutOfAttemptsScreen)
/// 2. Attempts Bottom Sheet when tapping "0 محاولات"
class DiscoverPlansScreen extends StatefulWidget {
  const DiscoverPlansScreen({super.key});

  @override
  State<DiscoverPlansScreen> createState() => _DiscoverPlansScreenState();
}

class _DiscoverPlansScreenState extends State<DiscoverPlansScreen> {
  static const List<PlanModel> _plans = [
    PlanModel(
      name: 'المجانية',
      badge: 'باقة البداية',
      price: 0,
      attempts: 3,
      days: 0,
      validityLabel: 'صالحة للاستخدام الأول',
      footer: '',
      isCurrent: true,
    ),
    PlanModel(
      name: 'فانكوش لايت',
      badge: 'الأوفر',
      price: 290,
      attempts: 20,
      days: 30,
      footer: 'بحث أسرع وتاريخ كامل',
    ),
    PlanModel(
      name: 'فانكوش بلس',
      price: 350,
      attempts: 40,
      days: 30,
      footer: 'بحث أسرع و افيهات اكثر',
      isPopular: true,
      isPopcornIcon: true,
    ),
  ];

  void _onSelectPlan(PlanModel plan) {
    if (plan.isCurrent) return;
    Navigator.pushNamed(context, AppRoutes.planCheckout, arguments: plan);
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
              // Top Bar with Profile avatar, Logo, and Notification bell
              AppTopBar(
                showBack: false,
                onProfileTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onNotificationTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      8.verticalSpace,

                      // Headline: "اختار باقتك وكمّل الضحك! 🎬"
                      _buildTitle(),

                      6.verticalSpace,

                      // Subtitle: "إفيهات أكثر، وضحك أكثر."
                      Text(
                        'إفيهات أكثر، وضحك أكثر.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666C7B),
                        ),
                      ),

                      18.verticalSpace,

                      // Plans List Cards
                      ..._plans.map((plan) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: _DiscoverPlanCard(
                            plan: plan,
                            onSelect: () => _onSelectPlan(plan),
                          ),
                        );
                      }),

                      6.verticalSpace,

                      // Bottom Info Note
                      _buildInfoBanner(),

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
  // Title with Clapperboard
  // ---------------------------------------------------------------------------
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'اختار باقتك وكمّل الضحك!',
          style: GoogleFonts.cairo(
            fontSize: 21.sp,
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
  // Bottom Info Banner
  // ---------------------------------------------------------------------------
  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFFFEDB8), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 15.sp,
            color: const Color(0xFFC48600),
          ),
          6.horizontalSpace,
          Expanded(
            child: Text(
              'كل باقة بتوضح عدد المحاولات ومدة الصلاحية قبل الاشتراك.',
              style: GoogleFonts.cairo(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFC48600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Discover Plan Card
// -----------------------------------------------------------------------------
class _DiscoverPlanCard extends StatelessWidget {
  final PlanModel plan;
  final VoidCallback onSelect;

  const _DiscoverPlanCard({required this.plan, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isSelected = plan.isPopular;
    final isBluePlan = plan.name == 'فانكوش لايت';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Container
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : (isBluePlan
                        ? const Color(0xFF90C2FF)
                        : const Color(0xFFF0EFEA)),
              width: isSelected || isBluePlan ? 1.5 : 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Title/Badge on Right, Price on Left
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Right: Plan Name + Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              plan.name,
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textHeadingDark,
                              ),
                            ),
                            if (plan.badge != null) ...[
                              8.horizontalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isBluePlan
                                      ? const Color(0xFFEAF2FF)
                                      : const Color(0xFFF1F2F4),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isBluePlan) ...[
                                      Image.asset(
                                        AppImages.iconTag,
                                        width: 10.w,
                                        height: 10.h,
                                        errorBuilder: (_, _, _) => const Icon(
                                          Icons.local_offer_outlined,
                                          size: 10,
                                          color: Color(0xFF2F80ED),
                                        ),
                                      ),
                                      4.horizontalSpace,
                                    ],
                                    Text(
                                      plan.badge!,
                                      style: GoogleFonts.cairo(
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isBluePlan
                                            ? const Color(0xFF2F80ED)
                                            : const Color(0xFF666C7B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        4.verticalSpace,
                        Text(
                          plan.price == 0
                              ? '3 محاولات صوتية للتعرف على الإفيه'
                              : '${plan.attempts} محاولة • صالحة لمدة ${plan.days} يوم',
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8C93A0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Left: Price (pushed down if popular to sit neatly below the badge)
                  Padding(
                    padding: EdgeInsets.only(top: plan.isPopular ? 16.h : 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${plan.price}',
                          style: GoogleFonts.cairo(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: isSelected
                                ? const Color(0xFFF5A623)
                                : (isBluePlan
                                      ? const Color(0xFF2F80ED)
                                      : AppColors.textHeadingDark),
                          ),
                        ),
                        4.horizontalSpace,
                        Text(
                          'جنيه',
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFFF5A623)
                                : (isBluePlan
                                      ? const Color(0xFF2F80ED)
                                      : const Color(0xFF8C93A0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              12.verticalSpace,

              // Subtle Divider
              Container(height: 1, color: const Color(0xFFF0EFEA)),

              10.verticalSpace,

              // Bottom Row: Footer on Right, Button on Left
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Right: Footer text / Validity
                  if (plan.validityLabel != null)
                    Text(
                      plan.validityLabel!,
                      style: GoogleFonts.cairo(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8C93A0),
                      ),
                    )
                  else
                    Row(
                      children: [
                        if (plan.isPopcornIcon) 4.horizontalSpace,
                        Image.asset(
                          plan.name.contains('لايت')
                              ? AppImages.iconFire
                              : AppImages.iconTag,
                          width: 14.w,
                          height: 14.h,
                          errorBuilder: (_, _, _) => Icon(
                            Icons.bolt_rounded,
                            size: 16.sp,
                            color: const Color(0xFFF5A623),
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          plan.footer,
                          style: GoogleFonts.cairo(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? const Color(0xFFB78103)
                                : const Color(0xFF8C93A0),
                          ),
                        ),
                      ],
                    ),

                  // Left: Action Button
                  if (plan.isCurrent)
                    // "باقتك الحالية" (disabled / grey outline)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F8),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        'باقتك الحالية',
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF8C93A0),
                        ),
                      ),
                    )
                  else if (isBluePlan)
                    // "اختار الباقة" (Blue Outline)
                    GestureDetector(
                      onTap: onSelect,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: const Color(0xFF2F80ED),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          'اختار الباقة',
                          style: GoogleFonts.cairo(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2F80ED),
                          ),
                        ),
                      ),
                    )
                  else
                    // "اختار الباقة" (Yellow Filled)
                    GestureDetector(
                      onTap: onSelect,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'اختار الباقة',
                          style: GoogleFonts.cairo(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1B2230),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        // "★ الأكثر اختيارًا" Badge on Top Left inside container, flush with border
        if (plan.isPopular)
          Positioned(
            top: 0,
            left: 14.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
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
                    width: 11.w,
                    height: 11.h,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.star_rounded,
                      size: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
