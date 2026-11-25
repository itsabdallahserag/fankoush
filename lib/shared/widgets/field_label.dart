import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';

/// Reusable bold field label displayed above input fields across the application.
class FieldLabel extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  const FieldLabel(
    this.text, {
    super.key,
    this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: style ?? AppTextStyles.bold14TextPrimary,
      ),
    );
  }
}
