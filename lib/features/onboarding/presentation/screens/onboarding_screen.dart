import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/shared/widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _pages = const [
    OnboardingModel(
      image: AppImages.onboardingLogo1,
      prefixTitle: AppStrings.onboardingPrefix1,
      highlightedWord: AppStrings.onboardingHighlight1,
      subtitle: AppStrings.onboardingSubtitle1,
      buttonText: AppStrings.nextAction,
    ),
    OnboardingModel(
      image: AppImages.onboardingLogo2,
      prefixTitle: AppStrings.onboardingPrefix2,
      highlightedWord: AppStrings.onboardingHighlight2,
      subtitle: AppStrings.onboardingSubtitle2,
      buttonText: AppStrings.startNow,
    ),
  ];

  void _onNext() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              // Top Bar with Skip ("تخطي")
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 24.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _navigateToLogin,
                    child: Text(
                      AppStrings.skip,
                      style: AppTextStyles.semibold16FD5C53,
                    ),
                  ),
                ),
              ),

              // PageView Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),

                          // Illustration Image
                          Image.asset(
                            page.image,
                            width: 345.w,
                            height: 286.h,
                            fit: BoxFit.contain,
                          ),

                          108.verticalSpace,

                          // Title with Yellow brush highlight underneath
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                page.prefixTitle,
                                style: AppTextStyles.extrabold311B2230,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Positioned(
                                    bottom: 6.h,
                                    child: Container(
                                      width: 96.w,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    page.highlightedWord,
                                    style: AppTextStyles.extrabold311B2230,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          10.verticalSpace,

                          // Subtitle
                          Text(
                            maxLines: 2,
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.semibold15666C7B,
                          ),

                          24.verticalSpace,

                          // Figma-exact Pagination Indicator Dots (10x10 circles)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_pages.length, (dotIndex) {
                              final bool isActive = _currentIndex == dotIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // In Figma: Active is Brand Yellow (#FEC529), Inactive is Neutral Gray (#D9D6CE)
                                  color: isActive
                                      ? AppColors.c399CFE
                                      : AppColors.cD9DCDF,
                                ),
                              );
                            }),
                          ),

                          34.verticalSpace,
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom Primary Action Button
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h),
                child: CustomElevatedButton(
                  text: _pages[_currentIndex].buttonText,
                  onPressed: _onNext,
                  borderRadius: 33.r,
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 24.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String image;
  final String prefixTitle;
  final String highlightedWord;
  final String subtitle;
  final String buttonText;

  const OnboardingModel({
    required this.image,
    required this.prefixTitle,
    required this.highlightedWord,
    required this.subtitle,
    required this.buttonText,
  });
}
