import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';

/// Birthday selection screen matching the reference design (Screen 3).
/// Allows interactive date selection with Year, Month, and Day wheels,
/// calculating the upcoming age dynamically.
class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  static const List<String> _months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  late final List<int> _years;
  late final List<int> _days;

  late int _selectedYear;
  late int _selectedMonthIndex; // 0-based, 9 = أكتوبر
  late int _selectedDay;

  late final FixedExtentScrollController _yearController;
  late final FixedExtentScrollController _monthController;
  late final FixedExtentScrollController _dayController;

  @override
  void initState() {
    super.initState();
    // Years from 1950 to current year
    final currentYear = DateTime.now().year;
    _years = List.generate(currentYear - 1949, (i) => 1950 + i);
    _days = List.generate(31, (i) => i + 1);

    // Default matching reference: 14 أكتوبر 1998
    _selectedYear = 1998;
    _selectedMonthIndex = 9; // أكتوبر
    _selectedDay = 14;

    final initialYearIndex = _years.indexOf(_selectedYear).clamp(0, _years.length - 1);
    final initialDayIndex = _days.indexOf(_selectedDay).clamp(0, _days.length - 1);

    _yearController = FixedExtentScrollController(initialItem: initialYearIndex);
    _monthController = FixedExtentScrollController(initialItem: _selectedMonthIndex);
    _dayController = FixedExtentScrollController(initialItem: initialDayIndex);
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  int get _calculatedAge {
    final now = DateTime.now();
    return now.year - _selectedYear;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      32.verticalSpace,

                      // Top Birthday Cake Icon with Halo
                      Container(
                        width: 76.r,
                        height: 76.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF6D9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFEC529).withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.birthdayIcon,
                            width: 44.r,
                            height: 44.r,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.cake_outlined,
                              size: 38.sp,
                              color: const Color(0xFFE5A800),
                            ),
                          ),
                        ),
                      ),

                      18.verticalSpace,

                      // Title: "اختار تاريخ ميلادك"
                      Text(
                        AppStrings.chooseBirthDate,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textHeadingDark,
                        ),
                      ),

                      24.verticalSpace,

                      // Wheel Date Picker Card
                      _buildDatePickerCard(),

                      32.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Actions
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Primary CTA: "حفظ التغييرات ✓"
                    GestureDetector(
                      onTap: () {
                        final formattedDate =
                            '$_selectedDay ${_months[_selectedMonthIndex]} $_selectedYear';
                        Navigator.maybePop(context, formattedDate);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(26.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.35),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'حفظ التاريخ',
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1B2230),
                              ),
                            ),
                            6.horizontalSpace,
                            Icon(
                              Icons.check_rounded,
                              size: 20.sp,
                              color: const Color(0xFF1B2230),
                            ),
                          ],
                        ),
                      ),
                    ),

                    10.verticalSpace,

                    // Secondary: "تخطي الآن"
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          AppStrings.skipForNow,
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF666C7B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Date Picker Card with 3 Columns (Year, Month, Day) & Highlight Bar
  // ---------------------------------------------------------------------------
  Widget _buildDatePickerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Column Headers Row (RTL: السنة, الشهر, اليوم)
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.yearHeader,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8C93A0),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.monthHeader,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8C93A0),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.dayHeader,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8C93A0),
                  ),
                ),
              ),
            ],
          ),

          14.verticalSpace,

          // 3-Wheel Area with Selection Highlight Overlay
          SizedBox(
            height: 140.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Highlight Yellow Pill Bar in Center with small Blue Dots on edges
                Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4D1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left blue dot (visual right in RTL)
                        Container(
                          width: 5.r,
                          height: 5.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFF399CFE),
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Right blue dot (visual left in RTL)
                        Container(
                          width: 5.r,
                          height: 5.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFF399CFE),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3 Interactive Scroll Wheels
                Row(
                  children: [
                    // Column 1: Year (Right in RTL)
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        controller: _yearController,
                        itemExtent: 44.h,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.003,
                        diameterRatio: 1.4,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedYear = _years[index];
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: _years.length,
                          builder: (context, index) {
                            final year = _years[index];
                            final isSelected = year == _selectedYear;
                            return Center(
                              child: Text(
                                '$year',
                                style: GoogleFonts.cairo(
                                  fontSize: isSelected ? 17.sp : 14.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF1B2230)
                                      : const Color(0xFF8C93A0).withOpacity(0.45),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Column 2: Month (Center)
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        controller: _monthController,
                        itemExtent: 44.h,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.003,
                        diameterRatio: 1.4,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMonthIndex = index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: _months.length,
                          builder: (context, index) {
                            final month = _months[index];
                            final isSelected = index == _selectedMonthIndex;
                            return Center(
                              child: Text(
                                month,
                                style: GoogleFonts.cairo(
                                  fontSize: isSelected ? 17.sp : 14.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF1B2230)
                                      : const Color(0xFF8C93A0).withOpacity(0.45),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Column 3: Day (Left in RTL)
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        controller: _dayController,
                        itemExtent: 44.h,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.003,
                        diameterRatio: 1.4,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedDay = _days[index];
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: _days.length,
                          builder: (context, index) {
                            final day = _days[index];
                            final isSelected = day == _selectedDay;
                            return Center(
                              child: Text(
                                '$day',
                                style: GoogleFonts.cairo(
                                  fontSize: isSelected ? 17.sp : 14.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF1B2230)
                                      : const Color(0xFF8C93A0).withOpacity(0.45),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          16.verticalSpace,

          // Footer calculation note: "سيكون عمرك القادم X سنة من الضحك والروقان 🎂"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cake_outlined,
                size: 15.sp,
                color: const Color(0xFF399CFE),
              ),
              6.horizontalSpace,
              RichText(
                text: TextSpan(
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    color: const Color(0xFF666C7B),
                  ),
                  children: [
                    const TextSpan(text: 'سيكون عمرك القادم '),
                    TextSpan(
                      text: '$_calculatedAge سنة',
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1B2230),
                      ),
                    ),
                    const TextSpan(text: ' من الضحك والروقان'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
