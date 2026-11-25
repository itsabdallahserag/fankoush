import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Reusable Elevated Button designed to match Figma button specifications.
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget? icon;
  final bool isIconLeading;
  final bool isLoading;
  final double elevation;
  final BorderSide? borderSide;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.width,
    this.height,
    this.borderRadius,
    this.icon,
    this.isIconLeading = false,
    this.isLoading = false,
    this.elevation = 0,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 52.h;
    final effectiveWidth = width ?? double.infinity;
    final effectiveRadius = borderRadius ?? 26.r;
    final effectiveBgColor = backgroundColor ?? AppColors.primary;
    final effectiveTextStyle = textStyle ?? AppTextStyles.bold18000000;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          elevation: elevation,
          disabledBackgroundColor: effectiveBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
            side: borderSide ?? BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null && isIconLeading) ...[
                    icon!,
                    8.horizontalSpace,
                  ],
                  Text(text, style: effectiveTextStyle),
                  if (icon != null && !isIconLeading) ...[
                    8.horizontalSpace,
                    icon!,
                  ],
                ],
              ),
      ),
    );
  }
}
