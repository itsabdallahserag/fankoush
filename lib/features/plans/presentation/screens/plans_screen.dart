import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';

class PlanModel {
  final String name;
  final int price;
  final int attempts;
  final int days;
  final String footer;
  final String? badge;
  final bool isPopular;
  final bool isPopcornIcon;
  final bool isCurrent;
  final String? validityLabel;

  const PlanModel({
    required this.name,
    required this.price,
    required this.attempts,
    required this.days,
    required this.footer,
    this.badge,
    this.isPopular = false,
    this.isPopcornIcon = false,
    this.isCurrent = false,
    this.validityLabel,
  });
}

/// Screen representing "Choose Your Plan and Keep the Jokes Going" (اختار باقتك وكمّل القفشات! 🎬).
/// Displayed directly after Login/Register:
/// - Centered Fankosh Logo with red/coral "تخطي الآن" on top right.
/// - Centered headline "اختار باقتك وكمّل القفشات! 🎬" and subtitle.
/// - 3 Plan Cards: فانكوش لايت (الاوفر), فانكوش بلس (الأكثر اختيارًا ★), فانكوش برو.
/// - Bottom Sticky Actions:
///   1. "متابعة للدفع (350 ج) ←" (arrow pointing left, on left of text).
///   2. "جرّب فانكوش مجانًا <" (arrow pointing left, on left of text) -> navigates to MainShell.
class PlansScreen extends StatefulWidget {
  final bool showSkip;

  const PlansScreen({super.key, this.showSkip = true});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  static const List<PlanModel> _plans = [
    PlanModel(
      name: 'فانكوش لايت',
      badge: 'الاوفر',
      price: 290,
      attempts: 20,
      days: 30,
      footer: 'بحث أسرع وضحك اكثر',
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
    PlanModel(
      name: 'فانكوش برو',
      price: 599,
      attempts: 100,
      days: 30,
      footer: 'بحث أسرع',
    ),
  ];

  // Default selected: فانكوش بلس (index 1) matching screenshot
  int _selected = 1;

  void _goHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.mainShell);
  }

  void _onContinue() {
    final plan = _plans[_selected];
    Navigator.pushNamed(context, AppRoutes.paymentMethod, arguments: plan);
  }

  @override
  Widget build(BuildContext context) {
    final selectedPlan = _plans[_selected];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      8.verticalSpace,

                      // Top Row: Skip on Right, Logo in Center
                      _buildTopHeader(),

                      14.verticalSpace,

                      // Headline: "اختار باقتك وكمّل القفشات! 🎬"
                      _buildTitle(),

                      8.verticalSpace,

                      // Subtitle
                      Text(
                        'جرّب فانكوش مجانًا، أو اختار باقتك واستمتع\nبقفشات أكثر!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666C7B),
                          height: 1.45,
                        ),
                      ),

                      22.verticalSpace,

                      // Plans List Cards
                      ...List.generate(_plans.length, (i) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: _PlanCard(
                            plan: _plans[i],
                            selected: i == _selected,
                            onTap: () => setState(() => _selected = i),
                          ),
                        );
                      }),

                      16.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Action Buttons
              _buildBottomActions(selectedPlan),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Header: "تخطي الآن" on Right + Centered Logo
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Right Item in RTL: "تخطي الآن" in coral red
          if (widget.showSkip)
            GestureDetector(
              onTap: _goHome,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 60.w,
                child: Text(
                  AppStrings.skipForNow,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFD5C53),
                  ),
                ),
              ),
            )
          else
            SizedBox(width: 60.w),

          // Center Logo
          Image.asset(
            AppImages.splashLogo,
            width: 136.w,
            height: 48.h,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => Text(
              'Fankosh',
              style: GoogleFonts.cairo(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),

          // Left Spacer in RTL to keep Logo centered
          SizedBox(width: 60.w),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Title with Clapperboard Emoji
  // ---------------------------------------------------------------------------
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'اختار باقتك وكمّل القفشات!',
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
  // Bottom Sticky Action Buttons
  // ---------------------------------------------------------------------------
  Widget _buildBottomActions(PlanModel selectedPlan) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary CTA: "متابعة للدفع (350 ج) ←"
          GestureDetector(
            onTap: _onContinue,
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
                    'متابعة للدفع (${selectedPlan.price} ج)',
                    style: GoogleFonts.cairo(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                  8.horizontalSpace,
                  Icon(
                    Icons.arrow_forward_outlined,
                    size: 20.sp,
                    color: const Color(0xFF1B2230),
                  ),
                ],
              ),
            ),
          ),

          10.verticalSpace,

          // Secondary Action: "جرّب فانكوش مجانًا <" with arrow on the LEFT
          GestureDetector(
            onTap: _goHome,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFFEBECEF), width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.tryFankoushFree,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF5A606E),
                    ),
                  ),
                  6.horizontalSpace,
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: const Color(0xFF5A606E),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Individual Plan Card
// -----------------------------------------------------------------------------
class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  final bool selected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card Container
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: selected ? AppColors.primary : const Color(0xFFF0EFEA),
                width: selected ? 1.5 : 1.2,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.22),
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
                // Top Row: Title & Badge on Right, Price on Left
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Right: Plan Name + (Optional Badge)
                    Column(
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
                                  color: const Color(0xFFF1F2F4),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  plan.badge!,
                                  style: GoogleFonts.cairo(
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF666C7B),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        4.verticalSpace,
                        Text(
                          '${plan.attempts} محاولة • صالحة لمدة ${plan.days} يوم',
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8C93A0),
                          ),
                        ),
                      ],
                    ),

                    // Left: Price "290 جنيه" (pushed down slightly if popular to sit neatly below the badge)
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
                              color: selected
                                  ? const Color(0xFFF5A623)
                                  : AppColors.textHeadingDark,
                            ),
                          ),
                          4.horizontalSpace,
                          Text(
                            'جنيه',
                            style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? const Color(0xFFF5A623)
                                  : const Color(0xFF8C93A0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                10.verticalSpace,

                // Subtle Divider
                Container(height: 1, color: const Color(0xFFF0EFEA)),

                8.verticalSpace,

                // Footer Row: Golden Lightning/Popcorn Icon + Footer Text aligned to the RIGHT
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (plan.isPopcornIcon)
                      Image.asset(AppImages.iconTag)
                    else
                      Image.asset(
                        AppImages.iconFire,
                        width: 16.w,
                        height: 16.h,
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
                        color: selected
                            ? const Color(0xFFB78103)
                            : const Color(0xFF8C93A0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // "الأكثر اختيارًا ★" Badge on Top Left inside container, flush with the border
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

                    Icon(Icons.star_rounded, size: 12.sp, color: Colors.white),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
