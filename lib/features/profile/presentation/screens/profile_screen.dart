import 'package:fankoush/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing "My Profile / Account" (حسابي - Tab 2).
/// Implements the exact design from the screenshots:
/// - Top Bar with Notification on Left, Logo in Center, Profile on Right.
/// - Top wavy background (profile_bg.png).
/// - Title: "حسابي", Subtitle: "كل حاجة تخص حسابك في مكان واحد".
/// - Card 1: User Profile info (Avatar on Right, Name & Email, "تعديل ✏️" capsule on Left).
/// - Card 2: Subscription status ("اشتراكي: فانكوش بلس", "• نشطة", "28 محاولة متبقية هذا الشهر", "← عرض باقتي").
/// - Section: "الإعدادات" (Settings list container with 7 items):
///   1. تاريخ الميلاد (أضف تاريخ ميلادك) -> BirthdayScreen
///   2. الإشعارات (التحكم في إشعارات فانكوش) -> NotificationsScreen
///   3. الدولة (مصر 🇪🇬) -> Opens "اختار دولتك 🌍" Bottom Sheet
///   4. اللغة (العربية) -> Opens "اختر اللغة" Bottom Sheet
///   5. الخصوصية والأمان (إعدادات الأمان والخصوصية)
///   6. المساعدة والدعم (محتاج مساعدة؟ إحنا هنا)
///   7. عن فانكوش (معلومات التطبيق والإصدار 1.0)
/// - Card 4: "تسجيل الخروج" with exit icon in red.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedCountry = 'مصر 🇪🇬';
  String _selectedLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Top Wavy Background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.profileBg,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),

            // Foreground Content
            SafeArea(
              child: Column(
                children: [
                  // App Top Bar: Profile avatar on Right, Logo in Center, Notification bell on Left
                  AppTopBar(
                    showBack: false,
                    onNotificationTap: () =>
                        Navigator.pushNamed(context, AppRoutes.notifications),
                  ),

                  // Scrollable Body
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          12.verticalSpace,

                          // Screen Title: "حسابي"
                          Center(
                            child: Text(
                              'حسابي',
                              style: GoogleFonts.cairo(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textHeadingDark,
                              ),
                            ),
                          ),

                          4.verticalSpace,

                          // Subtitle: "كل حاجة تخص حسابك في مكان واحد"
                          Center(
                            child: Text(
                              'كل حاجة تخص حسابك في مكان واحد',
                              style: GoogleFonts.cairo(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF666C7B),
                              ),
                            ),
                          ),

                          24.verticalSpace,

                          // Card 1: User Profile Card
                          _buildUserProfileCard(context),

                          16.verticalSpace,

                          // Card 2: Subscription Card
                          _buildSubscriptionCard(context),

                          20.verticalSpace,

                          // Section Title: "الإعدادات"
                          Text(
                            'الإعدادات',
                            style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textHeadingDark,
                            ),
                          ),

                          10.verticalSpace,

                          // Card 3: Settings Group Container
                          _buildSettingsGroup(context),

                          14.verticalSpace,

                          // Card 4: Logout Button
                          _buildLogoutButton(context),

                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card 1: User Profile Card (أحمد محمد)
  // ---------------------------------------------------------------------------
  Widget _buildUserProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // RIGHT: Avatar + Name & Email
          Row(
            children: [
              // Circular Avatar
              Container(
                width: 48.r,
                height: 48.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF4FE),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.iconPerson,
                    width: 32.r,
                    height: 32.r,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.account_circle_rounded,
                      color: const Color(0xFF399CFE),
                      size: 32.sp,
                    ),
                  ),
                ),
              ),

              12.horizontalSpace,

              // Name and Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أحمد محمد',
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textHeadingDark,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    'ahmed@example.com',
                    style: GoogleFonts.cairo(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666C7B),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // LEFT: "تعديل ✏️" capsule button
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'تعديل',
                    style: GoogleFonts.cairo(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE59A00),
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(
                    Icons.edit_outlined,
                    size: 13.sp,
                    color: const Color(0xFFFEC529),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card 2: Subscription Card ("اشتراكي: فانكوش بلس")
  // ---------------------------------------------------------------------------
  Widget _buildSubscriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Medal + Plan Name (Right) and "• نشطة" (Left)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // RIGHT: Medal Icon + "اشتراكي: فانكوش بلس"
              Row(
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5A623),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        AppImages.iconReward,
                        width: 18.r,
                        height: 18.r,
                        color: Colors.white,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.emoji_events_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),

                  8.horizontalSpace,

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'اشتراكي: ',
                          style: GoogleFonts.cairo(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF666C7B),
                          ),
                        ),
                        TextSpan(
                          text: 'فانكوش بلس',
                          style: GoogleFonts.cairo(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textHeadingDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // LEFT: "• نشطة" badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F8EE),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      'نشطة',
                      style: GoogleFonts.cairo(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          14.verticalSpace,

          // Bottom Row: "28 محاولة متبقية هذا الشهر" (Right), "← عرض باقتي" (Left)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // RIGHT: "28 محاولة متبقية هذا الشهر"
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '28',
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textHeadingDark,
                    ),
                  ),
                  4.horizontalSpace,
                  Text(
                    'محاولة متبقية هذا الشهر',
                    style: GoogleFonts.cairo(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF666C7B),
                    ),
                  ),
                ],
              ),

              // LEFT: "← عرض باقتي"
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.planDetails),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'عرض باقتي',
                      style: GoogleFonts.cairo(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2F80ED),
                      ),
                    ),
                    4.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.sp,
                      color: const Color(0xFF2F80ED),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card 3: Settings Group Container (قائمة الإعدادات)
  // ---------------------------------------------------------------------------
  Widget _buildSettingsGroup(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. تاريخ الميلاد
          _buildSettingTile(
            icon: Image.asset(
              AppImages.birthdayIconBlue,
              width: 20.r,
              height: 20.r,
              errorBuilder: (_, __, ___) => Icon(
                Icons.cake_outlined,
                size: 20.sp,
                color: const Color(0xFF9E7743),
              ),
            ),
            iconBgColor: const Color(0xFFFBF4E8),
            title: 'تاريخ الميلاد',
            subtitle: 'أضف تاريخ ميلادك',
            onTap: () => Navigator.pushNamed(context, AppRoutes.birthday),
          ),
          _buildDivider(),

          // 2. الإشعارات
          _buildSettingTile(
            icon: Image.asset(
              AppImages.iconNotification,
              width: 18.r,
              height: 18.r,
              color: const Color(0xFFF59E0B),
              errorBuilder: (_, __, ___) => Icon(
                Icons.notifications_none_rounded,
                size: 20.sp,
                color: const Color(0xFFF59E0B),
              ),
            ),
            iconBgColor: const Color(0xFFFFF3E8),
            title: 'الإشعارات',
            subtitle: 'التحكم في إشعارات فانكوش',
            onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          _buildDivider(),

          // 3. الدولة (تفتح نافذة اختيار الدولة)
          _buildSettingTile(
            icon: Icon(
              Icons.public_rounded,
              size: 20.sp,
              color: const Color(0xFF6B7280),
            ),
            iconBgColor: const Color(0xFFF3F4F6),
            title: 'الدولة',
            subtitle: _selectedCountry,
            onTap: () => _showCountryBottomSheet(context),
          ),
          _buildDivider(),

          // 4. اللغة (تفتح نافذة اختيار اللغة)
          _buildSettingTile(
            icon: Icon(
              Icons.language_rounded,
              size: 20.sp,
              color: const Color(0xFF6B7280),
            ),
            iconBgColor: const Color(0xFFF3F4F6),
            title: 'اللغة',
            subtitle: _selectedLanguage,
            onTap: () => _showLanguageBottomSheet(context),
          ),
          _buildDivider(),

          // 5. الخصوصية والأمان
          _buildSettingTile(
            icon: Icon(
              Icons.shield_outlined,
              size: 20.sp,
              color: const Color(0xFF6B7280),
            ),
            iconBgColor: const Color(0xFFF3F4F6),
            title: 'الخصوصية والأمان',
            subtitle: 'إعدادات الأمان والخصوصية',
            onTap: () {},
          ),
          _buildDivider(),

          // 6. المساعدة والدعم
          _buildSettingTile(
            icon: Image.asset(
              AppImages.iconHelp,
              width: 18.r,
              height: 18.r,
              errorBuilder: (_, __, ___) => Icon(
                Icons.support_agent_rounded,
                size: 20.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            iconBgColor: const Color(0xFFF3F4F6),
            title: 'المساعدة والدعم',
            subtitle: 'محتاج مساعدة؟ إحنا هنا',
            onTap: () {},
          ),
          _buildDivider(),

          // 7. عن فانكوش
          _buildSettingTile(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 20.sp,
              color: const Color(0xFF6B7280),
            ),
            iconBgColor: const Color(0xFFF3F4F6),
            title: 'عن فانكوش',
            subtitle: 'معلومات التطبيق والإصدار 1.0',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Setting Item Tile Helper
  // ---------------------------------------------------------------------------
  Widget _buildSettingTile({
    required Widget icon,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // RIGHT: Icon + Text
            Row(
              children: [
                Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(child: icon),
                ),

                12.horizontalSpace,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textHeadingDark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.cairo(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // LEFT: Chevron ( < )
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: const Color(0xFFD1D5DB),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF3F4F6),
      indent: 16,
      endIndent: 16,
    );
  }

  // ---------------------------------------------------------------------------
  // Card 4: Logout Button ("تسجيل الخروج")
  // ---------------------------------------------------------------------------
  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _confirmLogout(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // RIGHT: Logout Icon + "تسجيل الخروج"
            Row(
              children: [
                Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.logout_rounded,
                      size: 18.sp,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ),

                12.horizontalSpace,

                Text(
                  'تسجيل الخروج',
                  style: GoogleFonts.cairo(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),

            // LEFT: Chevron ( < )
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13.sp,
              color: const Color(0xFFFCA5A5),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تسجيل الخروج',
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),
              8.verticalSpace,
              Text(
                'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF666C7B),
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'إلغاء',
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF666C7B),
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'تأكيد الخروج',
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. Bottom Sheet: "اختار دولتك 🌍" (Image 1)
  // ===========================================================================
  void _showCountryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _CountrySelectionSheet(
        initialCountry: _selectedCountry,
        onCountrySelected: (newCountry) {
          setState(() {
            _selectedCountry = newCountry;
          });
        },
      ),
    );
  }

  // ===========================================================================
  // 2. Bottom Sheet: "اختر اللغة" (Image 2)
  // ===========================================================================
  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _LanguageSelectionSheet(
        initialLanguage: _selectedLanguage,
        onLanguageSelected: (newLanguage) {
          setState(() {
            _selectedLanguage = newLanguage;
          });
        },
      ),
    );
  }
}

// =============================================================================
// Country Selection Bottom Sheet Widget (Matching Image 1)
// =============================================================================
class _CountrySelectionSheet extends StatefulWidget {
  final String initialCountry;
  final ValueChanged<String> onCountrySelected;

  const _CountrySelectionSheet({
    required this.initialCountry,
    required this.onCountrySelected,
  });

  @override
  State<_CountrySelectionSheet> createState() => _CountrySelectionSheetState();
}

class _CountrySelectionSheetState extends State<_CountrySelectionSheet> {
  late String _currentSelected;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _allCountries = const [
    'مصر 🇪🇬',
    'السعودية 🇸🇦',
    'الإمارات 🇦🇪',
    'الكويت 🇰🇼',
    'قطر 🇶🇦',
    'البحرين 🇧🇭',
    'عُمان 🇴🇲',
    'الأردن 🇯🇴',
    'المغرب 🇲🇦',
  ];

  late List<String> _filteredCountries;

  @override
  void initState() {
    super.initState();
    _currentSelected = widget.initialCountry;
    _filteredCountries = List.from(_allCountries);
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredCountries = List.from(_allCountries);
      } else {
        _filteredCountries = _allCountries
            .where(
              (country) =>
                  country.toLowerCase().contains(query.trim().toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 600.h,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          children: [
            // Handle pill
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            12.verticalSpace,

            // Header Row: Title & Subtitle on RIGHT, ( × ) button on LEFT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RIGHT: Title & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'اختار دولتك',
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textHeadingDark,
                          ),
                        ),
                        6.horizontalSpace,
                        Text('🌍', style: TextStyle(fontSize: 16.sp)),
                      ],
                    ),
                    2.verticalSpace,
                    Text(
                      'اختار البلد اللي بتستخدم منها فانكوش.',
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666C7B),
                      ),
                    ),
                  ],
                ),

                // LEFT: Close ( × ) button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close_rounded,
                        size: 16.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            14.verticalSpace,

            // Search input field: "ابحث عن دولة..."
            Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F7F4),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFEBEAE5), width: 1.2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 19.sp,
                    color: const Color(0xFF8C93A0),
                  ),
                  10.horizontalSpace,
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
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        style: GoogleFonts.cairo(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textHeadingDark,
                        ),
                        cursorColor: AppColors.primary,
                        decoration: InputDecoration(
                          filled: false,
                          fillColor: Colors.transparent,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'ابحث عن دولة...',
                          hintStyle: GoogleFonts.cairo(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8C93A0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            12.verticalSpace,

            // Countries List
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredCountries.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF3F4F6),
                ),
                itemBuilder: (ctx, index) {
                  final country = _filteredCountries[index];
                  final isSelected = _currentSelected == country;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentSelected = country;
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF0F7FF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // RIGHT: Country name with flag
                          Text(
                            country,
                            style: GoogleFonts.cairo(
                              fontSize: 14.5.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF2F80ED)
                                  : AppColors.textHeadingDark,
                            ),
                          ),

                          // LEFT: Radio button (Selected: blue, Unselected: grey circle)
                          Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF2F80ED)
                                    : const Color(0xFFD1D5DB),
                                width: isSelected ? 5.5 : 1.5,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            12.verticalSpace,

            // Sticky Bottom CTA: "حفظ التغييرات"
            GestureDetector(
              onTap: () {
                widget.onCountrySelected(_currentSelected);
                Navigator.pop(context);
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
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'حفظ التغييرات',
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2230),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Language Selection Bottom Sheet Widget (Matching Image 2)
// =============================================================================
class _LanguageSelectionSheet extends StatefulWidget {
  final String initialLanguage;
  final ValueChanged<String> onLanguageSelected;

  const _LanguageSelectionSheet({
    required this.initialLanguage,
    required this.onLanguageSelected,
  });

  @override
  State<_LanguageSelectionSheet> createState() =>
      _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<_LanguageSelectionSheet> {
  late String _currentSelected;

  @override
  void initState() {
    super.initState();
    _currentSelected = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle pill
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            14.verticalSpace,

            // Header: "اختر اللغة" on the RIGHT
            Text(
              'اختر اللغة',
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.textHeadingDark,
              ),
            ),
            2.verticalSpace,
            Text(
              'اختر لغة عرض التطبيق.',
              style: GoogleFonts.cairo(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666C7B),
              ),
            ),

            20.verticalSpace,

            // Card 1: العربية (Arabic)
            _buildLanguageCard(
              title: 'العربية',
              subtitle: 'Arabic',
              badgeText: 'ع',
              badgeBg: const Color(0xFFEBF8FF),
              badgeBorder: const Color(0xFFBEE3F8),
              badgeTextColor: const Color(0xFF2F80ED),
              isSelected: _currentSelected == 'العربية',
              onTap: () {
                setState(() {
                  _currentSelected = 'العربية';
                });
              },
            ),

            12.verticalSpace,

            // Card 2: English (الإنجليزية)
            _buildLanguageCard(
              title: 'English',
              subtitle: 'الإنجليزية',
              badgeText: 'EN',
              badgeBg: const Color(0xFFFEF9C3),
              badgeBorder: const Color(0xFFFDE68A),
              badgeTextColor: const Color(0xFFD97706),
              isSelected: _currentSelected == 'English',
              onTap: () {
                setState(() {
                  _currentSelected = 'English';
                });
              },
            ),

            24.verticalSpace,

            // Save Button: "حفظ"
            GestureDetector(
              onTap: () {
                widget.onLanguageSelected(_currentSelected);
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'حفظ',
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),

            14.verticalSpace,

            // Cancel Button: "إلغاء"
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'إلغاء',
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1B2230),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeBg,
    required Color badgeBorder,
    required Color badgeTextColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8FAFF) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2F80ED)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2F80ED).withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // RIGHT: Badge + Titles
            Row(
              children: [
                // Circular Badge
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: badgeBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: badgeBorder, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      badgeText,
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: badgeTextColor,
                      ),
                    ),
                  ),
                ),

                12.horizontalSpace,

                // Title and Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textHeadingDark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.cairo(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666C7B),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // LEFT: Radio Button
            Container(
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2F80ED)
                      : const Color(0xFFD1D5DB),
                  width: isSelected ? 5.5 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
