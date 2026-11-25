import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';

/// Reusable circular or rounded Checkbox with title, matching Figma styling.
class CustomCheckboxTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;
  final TextStyle? titleStyle;

  const CustomCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            shape: const CircleBorder(),
            side: const BorderSide(
              color: AppColors.textSecondary,
              width: 1.2,
            ),
            activeColor: AppColors.primary,
            checkColor: AppColors.textPrimary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          4.horizontalSpace,
          Text(
            title,
            style: titleStyle ?? AppTextStyles.regular14TextSecondary,
          ),
        ],
      ),
    );
  }
}
