import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/core/utils/attempts_tracker.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';
import 'package:fankoush/shared/widgets/mic_permission_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _onMicTap(BuildContext context) async {
    if (!AttemptsTracker.hasAttempts) {
      Navigator.pushNamed(context, AppRoutes.outOfAttempts);
      return;
    }
    final allowed = await showMicPermissionDialog(context);
    if (allowed != true || !context.mounted) return;
    Navigator.pushNamed(context, AppRoutes.recordAudio);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppImages.homeBackground,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 110.h),
            child: Column(
              children: [
                AppTopBar(
                  onProfileTap: () =>
                      Navigator.pushNamed(context, AppRoutes.profile),
                  onNotificationTap: () =>
                      Navigator.pushNamed(context, AppRoutes.notifications),
                ),
                10.verticalSpace,

                // Attempts Chip (Tapping opens Screen 1: Attempts Bottom Sheet)
                ValueListenableBuilder<int>(
                  valueListenable: AttemptsTracker.attemptsNotifier,
                  builder: (context, count, _) => _AttemptsChip(
                    count: count,
                    onTap: () => _showAttemptsBottomSheet(context, count),
                  ),
                ),
                43.verticalSpace,

                // Character + Speech bubble (Tapping opens Screen 2: Birthday Prompt Dialog)
                GestureDetector(
                  onTap: () => _showBirthdayPromptDialog(context),
                  behavior: HitTestBehavior.opaque,
                  child: Image.asset(
                    AppImages.sayAnything,
                    width: 290.w,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
                16.verticalSpace,

                _MicButton(onTap: () => _onMicTap(context)),
                8.verticalSpace,

                Text(
                  AppStrings.pressToStartRecording,
                  style: AppTextStyles.bold16TextPrimary.copyWith(
                    fontSize: 16.sp,
                    color: const Color(0xFF1B2230),
                  ),
                ),
                8.verticalSpace,

                _UploadAudioButton(onTap: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AttemptsChip extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const _AttemptsChip({required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.softYellow,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColors.softGoldBorder, width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: [
            Image.asset(
              AppImages.iconTry,
              width: 18.r,
              height: 18.r,
              errorBuilder: (_, _, _) => Icon(
                Icons.bolt_rounded,
                size: 18.sp,
                color: const Color(0xFFF5A623),
              ),
            ),
            6.horizontalSpace,
            Text(
              '$count ${AppStrings.attempts}',
              style: AppTextStyles.bold14TextPrimary.copyWith(
                fontSize: 13.sp,
                color: const Color(0xFF1B2230),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  final VoidCallback onTap;
  const _MicButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 170.r,
        height: 170.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 170.r,
              height: 170.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x66FFF3C4),
              ),
            ),
            Container(
              width: 140.r,
              height: 140.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x99FFE896),
              ),
            ),
            Image.asset(
              AppImages.startAudio,
              width: 170.r,
              height: 170.r,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Container(
                width: 112.r,
                height: 112.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFC727), Color(0xFFF7931E)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF5A623).withOpacity(0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mic_rounded,
                  size: 48.sp,
                  color: const Color(0xFF1B2230),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadAudioButton extends StatelessWidget {
  final VoidCallback onTap;
  const _UploadAudioButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: const Color(0xFFE2C975), width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.rtl,
          children: [
            Image.asset(
              AppImages.iconUpload,
              width: 16.r,
              height: 16.r,
              color: const Color(0xFF5A606D),
              errorBuilder: (_, _, _) => Icon(
                Icons.file_upload_outlined,
                size: 16.sp,
                color: const Color(0xFF5A606D),
              ),
            ),
            8.horizontalSpace,
            Text(
              AppStrings.orUploadAudio,
              style: AppTextStyles.medium14TextSecondary.copyWith(
                fontSize: 13.sp,
                color: const Color(0xFF5A606D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Attempts Bottom Sheet (Matching Screen 1)
// -----------------------------------------------------------------------------
void _showAttemptsBottomSheet(BuildContext context, int count) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => _AttemptsBottomSheet(count: count),
  );
}

class _AttemptsBottomSheet extends StatelessWidget {
  final int count;

  const _AttemptsBottomSheet({required this.count});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Drag Handle
            Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            8.verticalSpace,

            // Close button on Top-Left (RTL visual left / trailing)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),

            // Halo with Yellow Lightning Bolt Icon
            Container(
              width: 68.r,
              height: 68.r,
              decoration: BoxDecoration(
                color: const Color(0x40FACC15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFFFFF), width: 2),
                    color: Color(0xFFFACC15),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '⚡',
                    style: GoogleFonts.cairo(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),

            14.verticalSpace,

            // Title: "محاولاتك في فانكوش ⚡"
            Text(
              AppStrings.yourAttemptsInFankosh,
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.textHeadingDark,
              ),
            ),

            4.verticalSpace,

            // Subtitle: "فاضلك X محاولات مجانية"
            Text(
              '${AppStrings.remainingFreeAttemptsPrefix} $count ${AppStrings.remainingFreeAttemptsSuffix}',
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6B7280),
              ),
            ),

            18.verticalSpace,

            // 3-Attempts Indicator Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF5),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: const Color(0xFFF6ECC8), width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Attempt 1 (Right in RTL)
                  _buildAttemptNode(number: 1, isAvailable: count >= 1),

                  // Connector
                  Container(
                    width: 28.w,
                    height: 1.5.h,
                    color: const Color(0xFFE8DEB8),
                  ),

                  // Attempt 2 (Center)
                  _buildAttemptNode(number: 2, isAvailable: count >= 2),

                  // Connector
                  Container(
                    width: 28.w,
                    height: 1.5.h,
                    color: const Color(0xFFE8DEB8),
                  ),

                  // Attempt 3 (Left in RTL)
                  _buildAttemptNode(number: 3, isAvailable: count >= 3),
                ],
              ),
            ),

            22.verticalSpace,

            // Blue Outline Button: "اكتشف الباقات >"
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.discoverPlans);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: const Color(0xFF3998FA), width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.discoverPlans,
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF3998FA),
                      ),
                    ),
                    6.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: const Color(0xFF3998FA),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttemptNode({required int number, required bool isAvailable}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: isAvailable ? AppColors.primary : const Color(0xFFEBECEF),
            shape: BoxShape.circle,
            boxShadow: isAvailable
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              '$number',
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: isAvailable
                    ? const Color(0xFF1B2230)
                    : const Color(0xFF8C93A0),
              ),
            ),
          ),
        ),
        6.verticalSpace,
        Text(
          isAvailable ? AppStrings.available : AppStrings.used,
          style: GoogleFonts.cairo(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w700,
            color: isAvailable
                ? const Color(0xFF6B5843)
                : const Color(0xFF8C93A0),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Birthday Prompt Dialog (Matching Screen 2)
// -----------------------------------------------------------------------------
void _showBirthdayPromptDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (ctx) => const _BirthdayPromptDialog(),
  );
}

class _BirthdayPromptDialog extends StatelessWidget {
  const _BirthdayPromptDialog();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          width: 330.w,
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button on Top-Left (RTL visual left / trailing)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.sp,
                      color: const Color(0xFF666C7B),
                    ),
                  ),
                ),
              ),

              // Calendar + Cake Illustration
              Image.asset(
                AppImages.birthdayImage,
                width: 130.w,
                height: 105.h,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Icon(
                  Icons.cake_outlined,
                  size: 60.sp,
                  color: const Color(0xFFF5A623),
                ),
              ),

              14.verticalSpace,

              // Title: "فانكوش عايز يعرف عيد ميلادك! 🎂"
              Text(
                AppStrings.fankoshWantsBirthdayTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 17.5.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),

              6.verticalSpace,

              // Subtitle: "ضيف تاريخ ميلادك عشان نفاجئك بتهنئة مخصوص في يومك!"
              Text(
                AppStrings.fankoshWantsBirthdaySubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF666C7B),
                ),
              ),

              18.verticalSpace,

              // Primary Button: "أضيف تاريخ ميلادي"
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.birthday);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.addMyBirthday,
                      style: GoogleFonts.cairo(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              10.verticalSpace,

              // Secondary Button: "مش دلوقتي"
              GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F2EE),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.notNow,
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4A4543),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
