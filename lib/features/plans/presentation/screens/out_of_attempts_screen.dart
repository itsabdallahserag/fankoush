import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "القفشات ببلاش خلصت!" (Out of Free Attempts).
/// Faithfully reproduces Screen B from the design reference:
/// - Top Bar with Notification (Left), Logo (Center), Profile (Right)
/// - "0 محاولات ⚡" Badge Chip
/// - Character Illustration (`finish_afsha.png`)
/// - Title & Subtitle ("القفشات ببلاش خلصت! / بس لسه عندنا ضحك كتير! / اختار باقتك وكمّل مع فانكوش.")
/// - 3-Item Features Card (قفشات أكثر, محاولات أكثر, ضحك مكمّل)
/// - Primary CTA: "اكتشف الباقات" (navigates to Plans)
/// - Secondary Button: "مش دلوقتي"
class OutOfAttemptsScreen extends StatelessWidget {
  const OutOfAttemptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 22.h,
              bottom: 28.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              children: [
                // Top Bar
                AppTopBar(
                  showBack: false,
                  showProfile: true,
                  showNotification: true,
                  onProfileTap: () =>
                      Navigator.pushNamed(context, AppRoutes.profile),
                  onNotificationTap: () =>
                      Navigator.pushNamed(context, AppRoutes.notifications),
                ),
                15.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Attempts Chip: "0 محاولات ⚡"
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softYellow,
                            borderRadius: BorderRadius.circular(22.r),
                            border: Border.all(
                              color: AppColors.softGoldBorder,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.zeroAttempts,
                                style: GoogleFonts.cairo(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1B2230),
                                ),
                              ),
                              6.horizontalSpace,
                              Image.asset(
                                AppImages.iconTry,
                                width: 16.r,
                                height: 16.r,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => Icon(
                                  Icons.bolt_rounded,
                                  size: 16.sp,
                                  color: const Color(0xFFF5A623),
                                ),
                              ),
                            ],
                          ),
                        ),

                        46.verticalSpace,

                        // Character Illustration (`finish_afsha.png`)
                        Image.asset(
                          AppImages.finishAfsha,
                          width: 230.w,
                          height: 200.h,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => Image.asset(
                            AppImages.sayAnything,
                            width: 230.w,
                            fit: BoxFit.contain,
                          ),
                        ),

                        26.verticalSpace,

                        // Title: "القفشات ببلاش خلصت!"
                        Text(
                          AppStrings.freeEfiehatFinished,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textHeadingDark,
                          ),
                        ),

                        6.verticalSpace,

                        // Subtitle
                        Text(
                          AppStrings.outOfAttemptsSubtitle1,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4E4633),
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          AppStrings.outOfAttemptsSubtitle2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4E4633),
                          ),
                        ),

                        26.verticalSpace,

                        // 3-Item Features Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: const Color(0xFFF0EFEA),
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x08000000),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Feature 1: قفشات أكثر
                              _buildFeatureItem(
                                icon: Icons.movie_creation_outlined,
                                label: AppStrings.moreEfiehat,
                              ),

                              // Divider
                              Container(
                                height: 36.h,
                                width: 1.w,
                                color: const Color(0xFFEBECEF),
                              ),

                              // Feature 2: محاولات أكثر
                              _buildFeatureItem(
                                icon: Icons.bolt_rounded,
                                label: AppStrings.moreAttempts,
                              ),

                              // Divider
                              Container(
                                height: 36.h,
                                width: 1.w,
                                color: const Color(0xFFEBECEF),
                              ),

                              // Feature 3: ضحك مكمّل
                              _buildFeatureItem(
                                icon: Icons.sentiment_satisfied_alt_rounded,
                                label: AppStrings.continuousLaughter,
                              ),
                            ],
                          ),
                        ),

                        36.verticalSpace,

                        // Primary Button: "اكتشف الباقات"
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.discoverPlans,
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
                                Icon(
                                  Icons.stars_rounded,
                                  size: 22.sp,
                                  color: const Color(0xFF1B2230),
                                ),
                                8.horizontalSpace,
                                Text(
                                  AppStrings.discoverPlans,
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1B2230),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        12.verticalSpace,

                        // Secondary Button: "مش دلوقتي"
                        GestureDetector(
                          onTap: () {
                            Navigator.maybePop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Center(
                              child: Text(
                                AppStrings.notNow,
                                style: GoogleFonts.cairo(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF666C7B),
                                ),
                              ),
                            ),
                          ),
                        ),

                        16.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String label}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7E6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.sp, color: const Color(0xFFF5A623)),
          ),
          8.verticalSpace,
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1B2230),
            ),
          ),
        ],
      ),
    );
  }
}
