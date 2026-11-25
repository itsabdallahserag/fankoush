import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/shared/widgets/custom_elevated_button.dart';

// Re-export FieldLabel from its reusable location so existing callers continue to work
export 'package:fankoush/shared/widgets/field_label.dart';

/// App logo + title + subtitle (Shared between Login and Register)
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            AppImages.splashLogo,
            width: 230.w,
            fit: BoxFit.contain,
          ),
        ),
        28.verticalSpace,
        Text(
          title,
          style: AppTextStyles.extrabold311B2230.copyWith(fontSize: 26.sp),
        ),
        8.verticalSpace,
        Text(
          subtitle,
          style: AppTextStyles.semibold15666C7B.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}

/// Auth Action Button using CustomElevatedButton with matching Figma shadow
class AuthButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CustomElevatedButton(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        icon: icon != null
            ? Icon(icon, size: 20.sp, color: AppColors.textPrimary)
            : null,
      ),
    );
  }
}

/// Bottom footer link (e.g. "لسه معندكش حساب؟ إنشاء حساب")
class AuthFooterLink extends StatelessWidget {
  final String prompt;
  final String linkText;
  final VoidCallback onTap;

  const AuthFooterLink({
    super.key,
    required this.prompt,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prompt, style: AppTextStyles.medium14TextSecondary),
        4.horizontalSpace,
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Text(
              linkText,
              style: AppTextStyles.bold14TextPrimary.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
