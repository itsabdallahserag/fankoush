import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/features/plans/presentation/screens/plans_screen.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "Choose Payment Method" (اختار طريقة الدفع).
/// Cleanly and accurately reproduces Screen 1 & Screen 2:
/// - AppTopBar with Notification bell on Left, Logo in Center, Profile on Right.
/// - Centered Top Label: "إتمام عملية الدفع بأمان وسرعة".
/// - Title Row: Back button ( > ) on the RIGHT, Title "اختار طريقة الدفع" in Center.
/// - Centered Subtitle: "اختار الطريقة اللي تناسبك وكمّل اشتراكك.".
/// - Plan Summary Box: Plan name & attempts on RIGHT, Price & "تغيير الباقة" on LEFT.
/// - Section Title: "طرق الدفع المتاحة" on RIGHT.
/// - 2 Payment Options (Unselected initially, selectable on tap):
///   - RIGHT: Icon box (icon_bank / icon_wallet)
///   - MIDDLE: Text column (Title & Subtitle)
///   - LEFT: Radio Button circle (unselected: empty, selected: golden with inner dot)
/// - Bottom Sticky: "الإجمالي المستحق" on RIGHT, "350 جنيه" on LEFT.
/// - CTA Button: "متابعة للدفع ←" -> navigates to CardPaymentScreen.
class PaymentMethodScreen extends StatefulWidget {
  final PlanModel? plan;

  const PaymentMethodScreen({super.key, this.plan});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // Starts with neither selected (null), matching Screen 1.
  int? _selectedMethod;

  void _onProceed(PlanModel plan) {
    if (_selectedMethod == 1) {
      Navigator.pushNamed(context, AppRoutes.walletPayment, arguments: plan);
    } else {
      // Default / Card option -> navigates to Screen 3 (CardPaymentScreen)
      Navigator.pushNamed(context, AppRoutes.cardPayment, arguments: plan);
    }
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

                      // Top Label: "إتمام عملية الدفع بأمان وسرعة" (Centered)
                      Text(
                        'إتمام عملية الدفع بأمان وسرعة',
                        style: GoogleFonts.cairo(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1B2230),
                        ),
                      ),

                      16.verticalSpace,

                      // Title Row: Back button ( > ) on the RIGHT, Title centered
                      _buildHeaderWithBack(),

                      8.verticalSpace,

                      // Subtitle: "اختار الطريقة اللي تناسبك وكمّل اشتراكك." (Centered)
                      Center(
                        child: Text(
                          'اختار الطريقة اللي تناسبك وكمّل اشتراكك.',
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

                      22.verticalSpace,

                      // Section Title: "طرق الدفع المتاحة" on the RIGHT
                      Text(
                        'طرق الدفع المتاحة',
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1B2230),
                        ),
                      ),

                      12.verticalSpace,

                      // Option 1: "بطاقة بنكية" (Bank Card)
                      _buildPaymentOption(
                        methodIndex: 0,
                        title: 'بطاقة بنكية',
                        subtitle: 'Visa • Mastercard • Meeza',
                        iconPath: AppImages.iconBank,
                        iconBgColor: const Color(0xFFFFF7E6),
                        fallbackIcon: Icons.credit_card_rounded,
                        fallbackIconColor: const Color(0xFFF5A623),
                      ),

                      12.verticalSpace,

                      // Option 2: "محفظة إلكترونية" (Electronic Wallet)
                      _buildPaymentOption(
                        methodIndex: 1,
                        title: 'محفظة إلكترونية',
                        subtitle: 'الدفع بالمحفظة',
                        iconPath: AppImages.iconWallet,
                        iconBgColor: const Color(0xFFFFF0F0),
                        fallbackIcon: Icons.account_balance_wallet_outlined,
                        fallbackIconColor: const Color(0xFFE53935),
                      ),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Summary & CTA Button
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
        8.horizontalSpace,
        Text(
          'اختار طريقة الدفع',
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
  // Payment Option Card
  // ---------------------------------------------------------------------------
  Widget _buildPaymentOption({
    required int methodIndex,
    required String title,
    required String subtitle,
    required String iconPath,
    required Color iconBgColor,
    required IconData fallbackIcon,
    required Color fallbackIconColor,
  }) {
    final isSelected = _selectedMethod == methodIndex;

    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = methodIndex),
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
            // 1. RIGHT in RTL: Icon Container
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 22.w,
                  height: 22.h,
                  errorBuilder: (_, _, _) =>
                      Icon(fallbackIcon, size: 20.sp, color: fallbackIconColor),
                ),
              ),
            ),

            12.horizontalSpace,

            // 2. MIDDLE in RTL: Title & Subtitle Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    subtitle,
                    style: GoogleFonts.cairo(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8C93A0),
                    ),
                  ),
                ],
              ),
            ),

            10.horizontalSpace,

            // 3. LEFT in RTL: Radio Button Circle
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
  // Bottom Sticky Summary & CTA
  // ---------------------------------------------------------------------------
  Widget _buildBottomSummaryAndCTA(PlanModel plan) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Due Row: "الإجمالي المستحق" on RIGHT, "350 جنيه" on LEFT
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${plan.price}',
                    style: GoogleFonts.cairo(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF5A623),
                    ),
                  ),
                  4.horizontalSpace,
                  Text(
                    'جنيه',
                    style: GoogleFonts.cairo(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF5A623),
                    ),
                  ),
                ],
              ),
            ],
          ),

          14.verticalSpace,

          // Primary CTA Button: "متابعة للدفع ←"
          GestureDetector(
            onTap: () => _onProceed(plan),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                color: const Color(0xFFEBECEF),
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'متابعة للدفع',
                    style: GoogleFonts.cairo(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                  8.horizontalSpace,
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.sp,
                    color: const Color(0xFF4B5563),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
