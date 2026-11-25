import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';

/// Standard Top Bar for screens in the Fankoush application.
/// Cleanly implements Figma design and logic:
/// - Main / Home Screen (`showBack: false`): Profile avatar in 45x45 #3C3C3C border circle (Right), Logo 142x52 (Center), Notification bell without dot (Left).
/// - Inner / Detail Screen (`showBack: true`): Back button (Right), Title/Logo (Center), Optional action (Left).
class AppTopBar extends StatelessWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final bool? showNotification;
  final VoidCallback? onNotificationTap;
  final bool? showProfile;
  final VoidCallback? onProfileTap;
  final Widget? action;

  const AppTopBar({
    super.key,
    this.title,
    this.showBack = false,
    this.onBack,
    this.showNotification,
    this.onNotificationTap,
    this.showProfile,
    this.onProfileTap,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShowProfile = showProfile ?? (!showBack);
    final effectiveShowNotification = showNotification ?? (!showBack);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Right Item in RTL: Back button or Profile avatar (45x45 px with #3C3C3C border)
          _buildLeading(context, effectiveShowProfile),

          // Center Item: Title text or Fankosh logo (142 px width × 52 px height)
          _buildCenter(),

          // Left Item in RTL: Action or Notification bell (without top dot)
          _buildTrailing(effectiveShowNotification),
        ],
      ),
    );
  }

  Widget _buildLeading(BuildContext context, bool showProfile) {
    const size = 32.0;

    if (showBack) {
      return GestureDetector(
        onTap: onBack ?? () => Navigator.maybePop(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: size.r,
          height: size.r,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.c3C3C3C, width: 1.2),
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18.sp,
            color: AppColors.c3C3C3C,
          ),
        ),
      );
    }

    if (showProfile) {
      return GestureDetector(
        onTap: onProfileTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: size.r,
          height: size.r,
          child: Image.asset(
            AppImages.iconProfile1,
            width: size.r,
            height: size.r,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => Image.asset(
              AppImages.iconProfileCircle,
              width: size.r,
              height: size.r,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Icon(
                Icons.account_circle_outlined,
                size: 34.sp,
                color: AppColors.c3C3C3C,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(width: size.r);
  }

  Widget _buildCenter() {
    if (title != null) {
      return Text(
        title!,
        style: AppTextStyles.bold18000000.copyWith(
          color: AppColors.textHeadingDark,
        ),
      );
    }

    return Image.asset(
      AppImages.splashLogo,
      width: 142.w,
      height: 52.h,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Text(
        'فانكوش 🎬',
        style: AppTextStyles.extrabold311B2230.copyWith(fontSize: 20.sp),
      ),
    );
  }

  Widget _buildTrailing(bool showNotification) {
    const size = 45.0;

    if (action != null) {
      return SizedBox(
        width: size.r,
        height: size.r,
        child: Center(child: action),
      );
    }

    if (showNotification) {
      return GestureDetector(
        onTap: onNotificationTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: size.r,
          height: size.r,
          child: Center(
            child: Image.asset(
              AppImages.iconNotification,
              width: 26.r,
              height: 26.r,
              color: AppColors.c3C3C3C,
              errorBuilder: (_, _, _) => Icon(
                Icons.notifications_none_rounded,
                size: 26.sp,
                color: AppColors.c3C3C3C,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(width: size.r);
  }
}
