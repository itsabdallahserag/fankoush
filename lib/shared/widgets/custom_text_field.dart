import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

typedef OnValidator = String? Function(String?);

/// Reusable Custom Text Field designed according to Figma input specifications.
class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final OnValidator? validator;
  final IconData? prefixIcon;
  final String? prefixImage;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final double radius;
  final Color? fillColor;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final FocusNode? focusNode;

  // ---- جديد ----
  /// اتجاه النص (مثلاً ltr للإيميل جوه شاشة RTL). الأيقونات بتفضل مكانها.
  final TextDirection? textDirection;

  /// محاذاة النص والـ hint.
  final TextAlign textAlign;

  /// نص صغير تحت الحقل (زي "استخدم 8 أحرف على الأقل.").
  final String? helperText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.prefixImage,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.radius = 27,
    this.fillColor,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.focusNode,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.helperText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _isObscured,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      style: AppTextStyles.medium16TextPrimary,
      cursorColor: AppColors.secondary,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ?? AppColors.surface,
        hintText: widget.hintText,
        hintStyle: AppTextStyles.regular14TextMuted,
        hintTextDirection: widget.textDirection,
        helperText: widget.helperText,
        helperStyle: AppTextStyles.regular14TextMuted.copyWith(fontSize: 12.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        prefixIcon: _buildPrefixIcon(),
        prefixIconConstraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
        suffixIcon: _buildSuffixIcon(),
        suffixIconConstraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
        border: _border(AppColors.border),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.secondary, width: 1.5),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, width: 1.5),
      ),
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixImage != null) {
      return Padding(
        padding: EdgeInsets.all(14.r),
        child: Image.asset(
          widget.prefixImage!,
          width: 20.r,
          height: 20.r,
          fit: BoxFit.contain,
          color: AppColors.textSecondary,
        ),
      );
    }
    if (widget.prefixIcon != null) {
      return Icon(
        widget.prefixIcon,
        color: AppColors.textSecondary,
        size: 22.sp,
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        onPressed: () => setState(() => _isObscured = !_isObscured),
        icon: Icon(
          _isObscured
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textSecondary,
          size: 22.sp,
        ),
      );
    }
    return widget.suffixIcon;
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius.r),
      borderSide: BorderSide(width: width, color: color),
    );
  }
}
