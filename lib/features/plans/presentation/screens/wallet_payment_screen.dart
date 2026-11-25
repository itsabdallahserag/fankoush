import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Pay With Wallet" (ادفع بمحفظتك).
/// Matches the left screen in the screenshot:
/// - AppTopBar with Notification on Left, Logo in Center, Profile on Right.
/// - Header: Back chevron button ( > ) on the RIGHT, Title "ادفع بمحفظتك" in Center.
/// - Subtitle: "اختار محفظتك وكمّل اشتراكك بسهولة وأمان".
/// - Plan Summary Box: Plan name & attempts on RIGHT, Price & "تغيير الباقة" on LEFT.
/// - Section: "اختار محفظتك" on RIGHT, "محافظ مصر الرقمية" on LEFT.
/// - 3 Wallet Options: Vodafone Cash (selected), Etisalat Cash, Orange Cash.
///   Each option has Brand icon on RIGHT, Title in MIDDLE, Radio button on LEFT.
/// - Mobile Number Field ("رقم الموبايل المرتبط بالمحفظة") with phone icon and green checkmark.
/// - Security Banner ("دفع آمن ومشفر").
/// - Bottom Sticky: "الإجمالي المستحق" on RIGHT, "350 جنيه مصري" on LEFT, and "ادفع الآن 🔒" button.
class WalletPaymentScreen extends StatefulWidget {
  final PlanModel? plan;

  const WalletPaymentScreen({super.key, this.plan});

  @override
  State<WalletPaymentScreen> createState() => _WalletPaymentScreenState();
}

class _WalletPaymentScreenState extends State<WalletPaymentScreen> {
  // 0 = Vodafone Cash (selected by default as in screenshot), 1 = Etisalat, 2 = Orange
  int _selectedWallet = 0;

  void _onPay(PlanModel plan) {
    Navigator.pushNamed(context, AppRoutes.paymentSuccess, arguments: plan);
  }

  @override
  Widget build(BuildContext context) {
    final effectivePlan =
        widget.plan ??
        const PlanModel(
          name: 'فانكوش بلس',
          price: 350,
          attempts: 40,
          days: 30,
          footer: 'بحث أسرع و افيهات اكثر',
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with Profile on Right, Logo in Center, Notification on Left
              AppTopBar(
                showBack: false,
                onProfileTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onNotificationTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.verticalSpace,

                      // Header Row: Back button ( > ) on the RIGHT, Title centered
                      _buildHeaderWithBack(),

                      4.verticalSpace,

                      // Subtitle: "اختار محفظتك وكمّل اشتراكك بسهولة وأمان"
                      Center(
                        child: Text(
                          'اختار محفظتك وكمّل اشتراكك بسهولة وأمان',
                          style: GoogleFonts.cairo(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666C7B),
                          ),
                        ),
                      ),

                      18.verticalSpace,

                      // Plan Summary Box
                      _buildPlanSummaryCard(effectivePlan),

                      20.verticalSpace,

                      // Section Header: "اختار محفظتك" on RIGHT, "محافظ مصر الرقمية" on LEFT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اختار محفظتك',
                            style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1B2230),
                            ),
                          ),
                          Text(
                            'محافظ مصر الرقمية',
                            style: GoogleFonts.cairo(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF8C93A0),
                            ),
                          ),
                        ],
                      ),

                      12.verticalSpace,

                      // Wallet Option 0: Vodafone Cash
                      _buildWalletOption(
                        index: 0,
                        title: 'فودافون كاش',
                        iconPath: AppImages.iconVodafone,
                      ),

                      10.verticalSpace,

                      // Wallet Option 1: Etisalat Cash
                      _buildWalletOption(
                        index: 1,
                        title: 'اتصالات كاش',
                        iconPath: AppImages.iconEtisalat,
                      ),

                      10.verticalSpace,

                      // Wallet Option 2: Orange Cash
                      _buildWalletOption(
                        index: 2,
                        title: 'أورنج كاش',
                        iconPath: AppImages.iconOrange,
                      ),

                      18.verticalSpace,

                      // Mobile Number Section
                      _buildMobileNumberSection(),

                      14.verticalSpace,

                      // Security Banner ("دفع آمن ومشفر")
                      _buildSecurityBanner(),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Summary & CTA ("ادفع الآن 🔒")
              _buildBottomSummaryAndCTA(effectivePlan),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header with Back button on the RIGHT and Title centered
  // ---------------------------------------------------------------------------
  Widget _buildHeaderWithBack() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 13.sp,
                color: const Color(0xFF1B2230),
              ),
            ),
          ),
        ),
        24.horizontalSpace,
        Text(
          'ادفع بمحفظتك',
          style: GoogleFonts.cairo(
            fontSize: 21.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textHeadingDark,
          ),
        ),

        // Back Button on the RIGHT (in RTL right: 0)
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Plan Summary Box
  // ---------------------------------------------------------------------------
  Widget _buildPlanSummaryCard(PlanModel plan) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // RIGHT side in RTL: Plan Name & Attempts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
              2.verticalSpace,
              Text(
                '${plan.attempts} محاولة • ${plan.days} يوم',
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8C93A0),
                ),
              ),
            ],
          ),

          // LEFT side in RTL: Price & "تغيير الباقة"
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${plan.price} جنيه',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
              2.verticalSpace,
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'تغيير الباقة',
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2F80ED),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Wallet Option Item
  // ---------------------------------------------------------------------------
  Widget _buildWalletOption({
    required int index,
    required String title,
    required String iconPath,
  }) {
    final isSelected = _selectedWallet == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedWallet = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFFDF5) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFF0EFEA),
            width: isSelected ? 1.5 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // 1. RIGHT in RTL: Brand Logo
            Image.asset(
              iconPath,
              width: 28.w,
              height: 28.h,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(
                Icons.account_balance_wallet_rounded,
                size: 24,
                color: Color(0xFFE53935),
              ),
            ),

            12.horizontalSpace,

            // 2. MIDDLE in RTL: Wallet Name
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B2230),
                ),
              ),
            ),

            10.horizontalSpace,

            // 3. LEFT in RTL: Radio Button
            Container(
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFFFFECC4)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFF5A623)
                      : const Color(0xFFE5E7EB),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5A623),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Mobile Number Section
  // ---------------------------------------------------------------------------
  Widget _buildMobileNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'رقم الموبايل المرتبط بالمحفظة',
          style: GoogleFonts.cairo(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1B2230),
          ),
        ),
        6.verticalSpace,
        Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
          ),
          child: Row(
            children: [
              // Phone Icon on RIGHT in RTL
              Image.asset(
                AppImages.iconPhoneNumber,
                width: 18.w,
                height: 18.h,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.phone_android_outlined,
                  size: 18,
                  color: Color(0xFF9CA3AF),
                ),
              ),

              Spacer(),
              // Phone Number in MIDDLE
              Text(
                '010 1234 5678',
                style: GoogleFonts.cairo(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 1.1,
                ),
              ),
              6.horizontalSpace,
              // Green verified checkmark circle on LEFT in RTL
              Container(
                width: 18.r,
                height: 18.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8FDF5),
                ),
                child: Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 12.sp,
                    color: const Color(0xFF20C997),
                  ),
                ),
              ),
            ],
          ),
        ),
        6.verticalSpace,
        Row(
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 14,
              color: Color(0xFF8C93A0),
            ),
            4.horizontalSpace,
            Expanded(
              child: Text(
                'اكتب الرقم المسجل عليه محفظتك لتلقي إشعار التأكيد.',
                style: GoogleFonts.cairo(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8C93A0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Security Banner ("دفع آمن ومشفر")
  // ---------------------------------------------------------------------------
  Widget _buildSecurityBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1),
      ),
      child: Row(
        children: [
          // Verified Shield on RIGHT in RTL
          Image.asset(
            AppImages.iconSafePayment,
            width: 20.w,
            height: 20.h,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.verified_user_outlined,
              size: 20,
              color: Color(0xFF10B981),
            ),
          ),

          10.horizontalSpace,

          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'دفع آمن ومشفر',
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2230),
                  ),
                ),
                2.verticalSpace,
                Text(
                  'نستخدم أعلى معايير الأمان لحماية بياناتك',
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF666C7B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Sticky Summary & CTA ("ادفع الآن 🔒")
  // ---------------------------------------------------------------------------
  Widget _buildBottomSummaryAndCTA(PlanModel plan) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Due Row: "الإجمالي المستحق" on RIGHT, "350 جنيه مصري" in golden on LEFT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'الإجمالي المستحق',
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1B2230),
                ),
              ),
              Text(
                '${plan.price} جنيه مصري',
                style: GoogleFonts.cairo(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF5A623),
                ),
              ),
            ],
          ),

          12.verticalSpace,

          // Primary Button: "ادفع الآن 🔒"
          GestureDetector(
            onTap: () => _onPay(plan),
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
                  Icon(
                    Icons.lock_rounded,
                    size: 18.sp,
                    color: const Color(0xFF1B2230),
                  ),
                  8.horizontalSpace,

                  Text(
                    'ادفع الآن',
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                ],
              ),
            ),
          ),

          8.verticalSpace,

          // Note below button
          Text(
            'هيتم تأكيد الدفع وتفعيل الباقة فورياً في حسابك.',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8C93A0),
            ),
          ),
        ],
      ),
    );
  }
}
