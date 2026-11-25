import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/shared/widgets/app_button.dart';

const Color _softGrey = Color(0xFFF1F2F4);

/// Displays animated microphone permission dialog matching Figma design.
/// Returns true if user clicked "سماح", false if "مش دلوقتي", null if dismissed.
Future<bool?> showMicPermissionDialog(BuildContext context) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'mic_permission',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, _, _) => const _MicPermissionDialog(),
    transitionBuilder: (context, animation, _, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      );
    },
  );
}

class _MicPermissionDialog extends StatelessWidget {
  const _MicPermissionDialog();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image (lisen_bg) covering the screen under the dialog
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Image.asset(
                  AppImages.lisenBg,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, _, _) => Image.asset(
                    AppImages.lisenBgIcon,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, _, _) => Image.asset(
                      AppImages.listenBg,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (_, _, _) => Image.asset(
                        AppImages.homeBackground,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Centered Permission Card
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 28.w),
                padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFDF95),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mic_rounded,
                          size: 30.sp,
                          color: AppColors.c3C3C3C,
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      AppStrings.micPermissionTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bold18000000.copyWith(
                        fontSize: 22.sp,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      AppStrings.micPermissionDesc,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular16TextSecondary.copyWith(
                        height: 1.6,
                      ),
                    ),
                    24.verticalSpace,
                    AppButton(
                      text: AppStrings.allow,
                      icon: Icons.check_circle_outline_rounded,
                      height: 48,
                      onPressed: () => Navigator.pop(context, true),
                    ),
                    12.verticalSpace,
                    AppSecondaryButton(
                      text: AppStrings.notNow,
                      height: 48,
                      backgroundColor: _softGrey,
                      borderColor: Colors.transparent,
                      textColor: AppColors.textSecondary,
                      onPressed: () => Navigator.pop(context, false),
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
}
