import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/features/home/presentation/screens/home_screen.dart';
import 'package:fankoush/features/plans/presentation/screens/my_plan_screen.dart';
import 'package:fankoush/features/profile/presentation/screens/profile_screen.dart';

/// Main Shell Screen providing Bottom Navigation Bar across primary sections.
/// Contains exactly 3 tabs: الرئيسية (Home), باقتي (My Plan), حسابي (Profile).
class MainShellScreen extends StatefulWidget {
  final int initialIndex;

  const MainShellScreen({super.key, this.initialIndex = 0});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomeScreen(),
    MyPlanScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: Container(
          height: 68.h,
          margin: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 13.h),
          decoration: BoxDecoration(
            color: const Color(0x61FFFFFF),
            borderRadius: BorderRadius.circular(34.r),
            border: Border.all(color: AppColors.textWhite, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabItem(
                    index: 0,
                    label: AppStrings.navHome,
                    imagePath: AppImages.iconHome,
                    fallbackIcon: Icons.home_outlined,
                  ),
                ),
                Expanded(
                  child: _buildTabItem(
                    index: 1,
                    label: AppStrings.navPlans,
                    imagePath: AppImages.iconFire,
                    fallbackIcon: Icons.bolt_rounded,
                  ),
                ),
                Expanded(
                  child: _buildTabItem(
                    index: 2,
                    label: AppStrings.navProfile,
                    imagePath: AppImages.iconProfile,
                    fallbackIcon: Icons.person_outline_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String label,
    required String imagePath,
    required IconData fallbackIcon,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.white : const Color(0xFF6B6965);
    final size = isSelected ? 24.r : 24.r;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        alignment: Alignment.center,
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: AppColors.primaryborder, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: size,
              height: size,
              color: color,
              errorBuilder: (_, _, _) =>
                  Icon(fallbackIcon, size: size, color: color),
            ),
            Text(
              label,
              style:
                  (isSelected
                          ? AppTextStyles.bold14TextPrimary
                          : AppTextStyles.regular12TextSecondary)
                      .copyWith(fontSize: 12.sp, color: color),
            ),
            if (isSelected) ...[
              3.verticalSpace,
              Container(
                width: 4.r,
                height: 4.r,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
