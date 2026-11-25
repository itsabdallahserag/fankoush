import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';
import 'package:fankoush/shared/widgets/audio_waveform.dart';

const Color _recordRed = Color(0xFFEF6461);

/// Screen 4: Record Audio Screen ("قول اللي في بالك.. ودوس لإنهاء التسجيل")
/// Matches Figma Frame 6 (1:6317) hierarchy, typography, and spacing identically.
class RecordAudioScreen extends StatefulWidget {
  const RecordAudioScreen({super.key});

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  static const int _maxSeconds = 60;
  static const int _barsCount = 50;

  final Stopwatch _stopwatch = Stopwatch();
  final math.Random _random = math.Random();
  final List<double> _recorded = [];

  Timer? _timer;
  bool _stopped = false;
  Duration _elapsed = Duration.zero;
  List<double> _levels = List.filled(_barsCount, 0.15);

  @override
  void initState() {
    super.initState();
    _startRecording();
  }

  void _startRecording() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _tick());
  }

  void _tick() {
    final double next = (_levels.last * 0.35 + _random.nextDouble() * 0.65)
        .clamp(0.12, 1.0)
        .toDouble();
    _recorded.add(next);

    if (mounted) {
      setState(() {
        _elapsed = _stopwatch.elapsed;
        _levels = [..._levels.sublist(1), next];
      });
    }

    if (_elapsed.inSeconds >= _maxSeconds) {
      _stopRecording();
    }
  }

  void _stopRecording() {
    if (_stopped) return;
    _stopped = true;
    _timer?.cancel();
    _stopwatch.stop();

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.reviewAudio,
      arguments: {'duration': _elapsed, 'levels': List<double>.from(_recorded)},
    );
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
    final blinkOn = (_elapsed.inMilliseconds ~/ 500).isEven;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with same alignment and spacing as other screens
              AppTopBar(
                onProfileTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onNotificationTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),

              // Main recording body with balanced spacing
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 60.h,
                  ),
                  child: Column(
                    children: [
                      20.verticalSpace,

                      // Heading: "قول اللي في بالك.. سامعينك!"
                      SizedBox(
                        width: 280.w,
                        child: Text(
                          AppStrings.recordTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.extrabold311B2230.copyWith(
                            fontSize: 26.sp,
                            height: 1.35,
                            color: const Color(0xFF1B2230),
                          ),
                        ),
                      ),
                      18.verticalSpace,

                      // Recording Status Card with Blinking Dot, Divider, and Timer (Figma 1:6334)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(33.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Blinking live red indicator
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: blinkOn ? 1.0 : 0.2,
                              child: Container(
                                width: 8.r,
                                height: 8.r,
                                decoration: const BoxDecoration(
                                  color: _recordRed,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            6.horizontalSpace,
                            Text(
                              AppStrings.recordingInProgress,
                              style: AppTextStyles.semiBold12TextPrimary
                                  .copyWith(fontSize: 12.sp, color: _recordRed),
                            ),
                            12.horizontalSpace,
                            // Vertical Divider
                            Container(
                              width: 1.w,
                              height: 14.h,
                              color: AppColors.border,
                            ),
                            12.horizontalSpace,
                            // Live elapsed timer
                            Text(
                              _formatTime(_elapsed),
                              style: AppTextStyles.bold18TextPrimary.copyWith(
                                fontSize: 16.sp,
                                color: const Color(0xFF1B2230),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Active Audio Waveform Spectrum
                      AudioWaveform(
                        levels: _levels,
                        height: 70.h,
                        barWidth: 3.5.w,
                        gap: 2.5.w,
                        activeColor: AppColors.primary,
                      ),

                      const Spacer(),

                      // End Recording Action Button (Figma 1:6377)
                      GestureDetector(
                        onTap: _stopRecording,
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 96.r,
                          height: 96.r,
                          child: Image.asset(
                            AppImages.endAudio,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      14.verticalSpace,

                      // End recording prompt label
                      Text(
                        AppStrings.pressToEndRecording,
                        style: AppTextStyles.bold16TextPrimary.copyWith(
                          fontSize: 15.sp,
                          color: const Color(0xFF1B2230),
                        ),
                      ),
                      6.verticalSpace,

                      // Max duration micro hint
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${AppStrings.maxRecordingDuration}$_maxSeconds${AppStrings.secondsUnit}',
                            style: AppTextStyles.medium12TextSecondary.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          4.horizontalSpace,
                          Icon(
                            Icons.timer_outlined,
                            size: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),

                      28.verticalSpace,
                    ],
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
