import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/routing/app_routes.dart';

/// Screen representing "Notifications" (الإشعارات).
/// Matches the reference screenshot with 100% precision:
/// - Background: AppColors.background.
/// - Top Bar:
///   - Back button ( > ) & Title "الإشعارات" on the RIGHT.
///   - "تحديد الكل كمقروء ✓✓" link button on the LEFT.
/// - Notification 1:
///   - Amber medal icon badge.
///   - Title: "باقتك اتفعلت! 🎉"
///   - Subtitle: "اشتراكك جاهز... يلا نكمّل قفشات!"
///   - Time: "11:30 ص"
///   - Red unread indicator dot.
/// - Notification 2:
///   - Blue lightning icon badge.
///   - Title: "محاولاتك قربت تخلص!"
///   - Subtitle: "فاضلك محاولتين بس!"
///   - Time: "أمس"
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Notification items state
  late List<_NotificationItem> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      _NotificationItem(
        id: '1',
        title: 'باقتك اتفعلت! 🎉',
        subtitle: 'اشتراكك جاهز... يلا نكمّل قفشات!',
        time: '11:30 ص',
        isUnread: true,
        iconBgColor: const Color(0xFFFFF7ED),
        iconColor: const Color(0xFFF5A623),
        iconType: _NotifIconType.reward,
        targetRoute: AppRoutes.planDetails,
      ),
      _NotificationItem(
        id: '2',
        title: 'محاولاتك قربت تخلص!',
        subtitle: 'فاضلك محاولتين بس!',
        time: 'أمس',
        isUnread: false,
        iconBgColor: const Color(0xFFEBF5FF),
        iconColor: const Color(0xFF2F80ED),
        iconType: _NotifIconType.bolt,
        targetRoute: AppRoutes.changePlan,
      ),
    ];
  }

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item.isUnread = false;
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
              8.verticalSpace,

              // Top Bar: Back & Title on RIGHT, "تحديد الكل كمقروء" on LEFT
              _buildHeader(context),

              20.verticalSpace,

              // Notifications List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => 12.verticalSpace,
                  itemBuilder: (context, index) {
                    final item = _notifications[index];
                    return _buildNotificationCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Header Bar
  // ---------------------------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // RIGHT: Back Button + Title "الإشعارات"
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.2,
                    ),
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

              12.horizontalSpace,

              Text(
                'الإشعارات',
                style: GoogleFonts.cairo(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),
            ],
          ),

          // LEFT: "تحديد الكل كمقروء ✓✓"
          GestureDetector(
            onTap: _markAllAsRead,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.done_all_rounded,
                  size: 16.sp,
                  color: const Color(0xFF2F80ED),
                ),
                4.horizontalSpace,

                Text(
                  'تحديد الكل كمقروء',
                  style: GoogleFonts.cairo(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2F80ED),
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
  // Notification Card
  // ---------------------------------------------------------------------------
  Widget _buildNotificationCard(_NotificationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isUnread = false;
        });
        if (item.targetRoute != null) {
          Navigator.pushNamed(context, item.targetRoute!);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RIGHT: Icon Badge + Titles
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon Badge container
                  Container(
                    width: 42.r,
                    height: 42.r,
                    decoration: BoxDecoration(
                      color: item.iconBgColor,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: item.iconType == _NotifIconType.reward
                          ? Image.asset(
                              AppImages.iconReward,
                              width: 22.r,
                              height: 22.r,
                              color: item.iconColor,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.emoji_events_rounded,
                                size: 22.sp,
                                color: item.iconColor,
                              ),
                            )
                          : Icon(
                              Icons.bolt_rounded,
                              size: 24.sp,
                              color: item.iconColor,
                            ),
                    ),
                  ),

                  12.horizontalSpace,

                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.cairo(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textHeadingDark,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          item.subtitle,
                          style: GoogleFonts.cairo(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666C7B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            10.horizontalSpace,

            // LEFT: Time and Unread Dot
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.time,
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                if (item.isUnread) ...[
                  8.verticalSpace,
                  Container(
                    width: 7.r,
                    height: 7.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum _NotifIconType { reward, bolt }

class _NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  bool isUnread;
  final Color iconBgColor;
  final Color iconColor;
  final _NotifIconType iconType;
  final String? targetRoute;

  _NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
    required this.iconBgColor,
    required this.iconColor,
    required this.iconType,
    this.targetRoute,
  });
}
