import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';

/// Reusable Country Picker Modal Bottom Sheet
class CountryPickerBottomSheet {
  static const List<String> defaultCountries = [
    'مصر 🇪🇬',
    'السعودية 🇸🇦',
    'الإمارات 🇦🇪',
    'الكويت 🇰🇼',
    'قطر 🇶🇦',
    'الأردن 🇯🇴',
  ];

  static Future<String?> show({
    required BuildContext context,
    required String currentCountry,
    List<String> countries = defaultCountries,
  }) {
    FocusScope.of(context).unfocus();

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              16.verticalSpace,
              // Drag Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              12.verticalSpace,
              Text(
                'اختر الدولة',
                style: AppTextStyles.bold16TextPrimary,
              ),
              8.verticalSpace,
              const Divider(color: AppColors.border),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    final bool isSelected = country == currentCountry;

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                      title: Text(
                        country,
                        style: isSelected
                            ? AppTextStyles.bold14TextPrimary
                            : AppTextStyles.regular14TextPrimary,
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_rounded, color: AppColors.primary)
                          : null,
                      onTap: () => Navigator.pop(sheetContext, country),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
