import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';

/// Primary action button with gold/yellow background, shadow and RTL support.
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? iconWidget;
  final double height;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.height = 52,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((height / 2).r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          disabledBackgroundColor: AppColors.primary,
          elevation: 0,
          shape: const StadiumBorder(),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.r,
                height: 22.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.textPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text, style: AppTextStyles.bold14TextPrimary),
                  if (iconWidget != null) ...[
                    8.horizontalSpace,
                    iconWidget!,
                  ] else if (icon != null) ...[
                    8.horizontalSpace,
                    Icon(icon, size: 20.sp, color: AppColors.textPrimary),
                  ],
                ],
              ),
      ),
    );
  }
}

/// Secondary action button (outlined or filled neutral).
class AppSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? iconWidget;
  final double height;
  final double fontSize;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  /// true = expands to parent width, false = wraps content
  final bool expand;

  const AppSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.height = 48,
    this.fontSize = 14,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final fg = textColor ?? AppColors.textSecondary;

    return SizedBox(
      width: expand ? double.infinity : null,
      height: height.h,
      child: Material(
        color: backgroundColor ?? AppColors.surface,
        shape: StadiumBorder(
          side: BorderSide(color: borderColor ?? AppColors.border),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconWidget != null) ...[
                  iconWidget!,
                  6.horizontalSpace,
                ] else if (icon != null) ...[
                  Icon(icon, size: (fontSize + 4).sp, color: fg),
                  6.horizontalSpace,
                ],
                Text(
                  text,
                  style: AppTextStyles.bold14TextPrimary.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize.sp,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
