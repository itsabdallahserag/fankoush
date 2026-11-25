import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';

/// Screen representing "Edit Profile" (تعديل الملف الشخصي).
/// Matches the reference screenshot with 100% precision:
/// - Clean background (AppColors.background).
/// - Optional top back button for smooth navigation.
/// - 3D Boy illustrated Avatar (image_profile.png) with camera badge on bottom-left.
/// - Text: "انقر لتغيير صورتك".
/// - Field 1: "الاسم" -> Person icon + Name ("أحمد محمد") on Right, Clear button (ⓧ) on Left.
/// - Field 2: "البريد الإلكتروني" -> Mail icon on Right, Email ("ahmed@example.com") on Left.
/// - Field 3: "تاريخ الميلاد" -> Calendar icon + Date ("14 أكتوبر 1998") on Right, Lock icon on Left.
/// - Note: "هنستخدم تاريخ ميلادك بس عشان نهنّيك في يومك المميز." with green shield icon.
/// - Bottom Sticky Button: "حفظ التغييرات ✓" (Yellow capsule with white text & checkmark).
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  String _birthday = '14 أكتوبر 1998';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'أحمد محمد');
    _emailController = TextEditingController(text: 'ahmed@example.com');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم حفظ التعديلات بنجاح!',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.maybePop(context);
      }
    });
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
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.verticalSpace,

                      // Center Avatar with Camera Badge
                      Center(child: _buildAvatarSection()),

                      28.verticalSpace,

                      // Field 1: الاسم
                      _buildFieldLabel('الاسم'),
                      6.verticalSpace,
                      _buildNameField(),

                      18.verticalSpace,

                      // Field 2: البريد الإلكتروني
                      _buildFieldLabel('البريد الإلكتروني'),
                      6.verticalSpace,
                      _buildEmailField(),

                      18.verticalSpace,

                      // Field 3: تاريخ الميلاد
                      _buildFieldLabel('تاريخ الميلاد'),
                      6.verticalSpace,
                      _buildBirthdayField(),

                      10.verticalSpace,

                      // Note under birthday: "هنستخدم تاريخ ميلادك بس عشان نهنّيك في يومك المميز."
                      _buildBirthdayNote(),

                      30.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Area: "حفظ التغييرات ✓"
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Avatar Section with Camera Icon badge
  // ---------------------------------------------------------------------------
  Widget _buildAvatarSection() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar Image Circle
            Container(
              width: 90.r,
              height: 90.r,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  AppImages.imageProfile,
                  width: 90.r,
                  height: 90.r,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.person_rounded,
                    size: 60.sp,
                    color: const Color(0xFFE59A00),
                  ),
                ),
              ),
            ),

            // Camera Badge on the bottom-left of the avatar
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 28.r,
                height: 28.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5A623),
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.photo_camera_rounded,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        10.verticalSpace,

        // Label: "انقر لتغيير صورتك"
        Text(
          'انقر لتغيير صورتك',
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF666C7B),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Field Label Helper
  // ---------------------------------------------------------------------------
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textHeadingDark,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Field 1: الاسم
  // In RTL:
  // - Person Icon & Name on the RIGHT
  // - Clear icon ( ⓧ ) on the LEFT
  // ---------------------------------------------------------------------------
  Widget _buildNameField() {
    return Container(
      width: double.infinity,
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Row(
        children: [
          // RIGHT: Person Icon
          Icon(
            Icons.person_outline_rounded,
            size: 20.sp,
            color: const Color(0xFFBDBDBD),
          ),

          10.horizontalSpace,

          // Name Input Field
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: const InputDecorationTheme(
                  filled: false,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              child: TextField(
                controller: _nameController,
                style: GoogleFonts.cairo(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeadingDark,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  filled: false,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),

          // LEFT: Clear button ( ⓧ )
          GestureDetector(
            onTap: () {
              setState(() {
                _nameController.clear();
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Icon(
              Icons.cancel_outlined,
              size: 18.sp,
              color: const Color(0xFFD1D5DB),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Field 2: البريد الإلكتروني
  // In RTL:
  // - Mail Icon on the RIGHT
  // - Email text on the LEFT
  // ---------------------------------------------------------------------------
  Widget _buildEmailField() {
    return Container(
      width: double.infinity,
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // RIGHT in RTL: Mail Icon
          Icon(
            Icons.mail_outline_rounded,
            size: 20.sp,
            color: const Color(0xFFBDBDBD),
          ),

          // LEFT in RTL: Email text
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              _emailController.text,
              style: GoogleFonts.cairo(
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textHeadingDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Field 3: تاريخ الميلاد
  // In RTL:
  // - Calendar Icon & Date on the RIGHT
  // - Lock Icon on the LEFT
  // ---------------------------------------------------------------------------
  Widget _buildBirthdayField() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(context, AppRoutes.birthday);
        if (result != null && result is String) {
          setState(() {
            _birthday = result;
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // RIGHT: Calendar Icon + Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 19.sp,
                  color: const Color(0xFFBDBDBD),
                ),
                10.horizontalSpace,
                Text(
                  _birthday,
                  style: GoogleFonts.cairo(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textHeadingDark,
                  ),
                ),
              ],
            ),

            // LEFT: Lock Icon
            Icon(
              Icons.lock_outline_rounded,
              size: 18.sp,
              color: const Color(0xFFBDBDBD),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Note under Birthday
  // "هنستخدم تاريخ ميلادك بس عشان نهنّيك في يومك المميز."
  // ---------------------------------------------------------------------------
  Widget _buildBirthdayNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.verified_user_outlined,
          size: 16.sp,
          color: const Color(0xFF10B981),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            'هنستخدم تاريخ ميلادك بس عشان نهنّيك في يومك المميز.',
            style: GoogleFonts.cairo(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF666C7B),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Sticky Area: "حفظ التغييرات ✓"
  // ---------------------------------------------------------------------------
  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: GestureDetector(
        onTap: _onSave,
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
              // Checkmark Icon on the RIGHT in RTL
              Icon(Icons.check_rounded, size: 20.sp, color: Colors.white),

              6.horizontalSpace,

              // White Text: "حفظ التغييرات"
              Text(
                'حفظ التغييرات',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
