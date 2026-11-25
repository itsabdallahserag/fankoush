import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/shared/widgets/app_button.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';
import 'package:fankoush/shared/widgets/audio_waveform.dart';
import 'package:fankoush/features/recording/presentation/screens/record_audio_screen.dart';

const Color _orange = Color(0xFFF5A623);
const Color _softGrey = Color(0xFFF1F2F4);
const Color _waveInactive = Color(0xFFE5E7EB);

/// Screen 5: Review Audio Screen ("ده تسجيلك!")
class ReviewAudioScreen extends StatefulWidget {
  final Duration duration;
  final List<double> levels;
  final String? audioPath;

  const ReviewAudioScreen({
    super.key,
    this.duration = const Duration(seconds: 12),
    this.levels = const [],
    this.audioPath,
  });

  @override
  State<ReviewAudioScreen> createState() => _ReviewAudioScreenState();
}

class _ReviewAudioScreenState extends State<ReviewAudioScreen> {
  Timer? _timer;
  bool _isPlaying = false;
  Duration _position = Duration.zero;

  late final List<double> _levels = widget.levels.isNotEmpty
      ? widget.levels
      : List.generate(50, (i) => 0.2 + 0.6 * math.sin(i * 0.7).abs());

  double get _progress {
    final total = math.max(1, widget.duration.inMilliseconds);
    return (_position.inMilliseconds / total).clamp(0.0, 1.0).toDouble();
  }

  void _togglePlay() {
    if (_isPlaying) {
      _timer?.cancel();
      setState(() => _isPlaying = false);
      return;
    }

    if (_position >= widget.duration) {
      _position = Duration.zero;
    }
    setState(() => _isPlaying = true);

    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      final next = _position + const Duration(milliseconds: 100);
      if (next >= widget.duration) {
        t.cancel();
        if (mounted) {
          setState(() {
            _position = widget.duration;
            _isPlaying = false;
          });
        }
      } else {
        if (mounted) {
          setState(() => _position = next);
        }
      }
    });
  }

  void _reRecord() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RecordAudioScreen()),
    );
  }

  void _delete() {
    _timer?.cancel();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _findJoke() {
    _timer?.cancel();
    Navigator.pushNamed(context, AppRoutes.findingEfieh);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
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
              AppTopBar(
                onProfileTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onNotificationTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 42.h,
                    right: 40.w,
                    left: 40.w,
                    bottom: 54.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.yourRecording,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.extraBold28TextPrimary.copyWith(
                          fontSize: 28.sp,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        AppStrings.reviewSubtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regular16TextSecondary.copyWith(),
                      ),

                      34.verticalSpace,

                      // Audio Waveform with progress
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.textWhite,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            AudioWaveform(
                              levels: _levels,
                              progress: _progress,
                              reverse: true,
                              height: 110.h,
                              barWidth: 3.5.w,
                              gap: 2.5.w,
                              activeColor: AppColors.primary,
                              inactiveColor: _waveInactive,
                              playheadColor: _orange,
                            ),
                            10.verticalSpace,

                            // Timer indicator
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatTime(_position),
                                  style: AppTextStyles.semiBold12TextPrimary,
                                ),
                                Text(
                                  _formatTime(widget.duration),
                                  style: AppTextStyles.semiBold12TextPrimary,
                                ),
                              ],
                            ),

                            24.verticalSpace,

                            // Play / Pause Circle Button
                            GestureDetector(
                              onTap: _togglePlay,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 68.r,
                                height: 68.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary,
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  size: 34.sp,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      28.verticalSpace,

                      // Action Chips: "سجل من جديد" & "حذف التسجيل"
                      Row(
                        children: [
                          Expanded(
                            child: _ActionChip(
                              icon: Icons.mic_none,
                              iconColor: _orange,
                              label: AppStrings.reRecord,
                              onTap: _reRecord,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: _ActionChip(
                              icon: Icons.delete_outline_outlined,
                              iconColor: AppColors.error,
                              label: AppStrings.deleteRecording,
                              onTap: _delete,
                            ),
                          ),
                        ],
                      ),

                      24.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Bottom Button "يلا نلاقي الإفيه!"
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
                child: AppButton(
                  text: AppStrings.findEfieh,
                  icon: Icons.auto_awesome_rounded,
                  height: 54,
                  onPressed: _findJoke,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _softGrey,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: iconColor),
              8.horizontalSpace,
              Text(
                label,
                style: AppTextStyles.bold14TextPrimary.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
