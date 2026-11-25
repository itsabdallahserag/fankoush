import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/core/utils/attempts_tracker.dart';
import 'package:fankoush/shared/widgets/app_top_bar.dart';

/// Screen representing the Finding Efieh and Result experience.
/// Perfectly reproduces Figma Frame 9 (and Frame 8 for searching state):
/// - Right-aligned user speech bubble & headline.
/// - Left-aligned AI response speech bubble ("أيوووه! قفشت الإفيه! 😍").
/// - Full-width audio player card ("خد الإفيه ده عندك! 🎧").
/// - Correctly oriented bottom input dock (Mic on right, text, document icon on left).
class FindingEfiehScreen extends StatefulWidget {
  final bool initialSearching;

  const FindingEfiehScreen({super.key, this.initialSearching = true});

  @override
  State<FindingEfiehScreen> createState() => _FindingEfiehScreenState();
}

class _FindingEfiehScreenState extends State<FindingEfiehScreen> {
  late bool _isSearching;

  // Search animation timer
  Timer? _searchTimer;
  Timer? _dotTimer;
  int _activeDotIndex = 0;

  // User Voice Player state
  bool _isUserVoicePlaying = false;
  Timer? _userVoiceTimer;
  int _userVoiceSeconds = 6;

  // Result Efieh Audio Player state
  bool _isResultPlaying = false;
  Timer? _resultAudioTimer;
  int _resultCurrentSeconds = 8;
  final int _resultTotalSeconds = 22;

  // Waveform bars for user voice bubble
  static const List<double> _userWaveform = [
    0.35,
    0.65,
    0.30,
    0.55,
    0.85,
    0.40,
    0.70,
    1.00,
    0.55,
    0.85,
    0.30,
    0.70,
    0.40,
  ];

  // Waveform bars for result efieh player (Figma Frame 1:6649-1:6668)
  static const List<double> _efiehWaveform = [
    0.30,
    0.60,
    0.40,
    0.70,
    0.90,
    0.50,
    0.80,
    0.60,
    1.00,
    0.90,
    0.50,
    0.70,
    1.00,
    0.80,
    0.40,
    0.90,
    0.60,
    1.00,
    0.70,
    0.40,
  ];

  @override
  void initState() {
    super.initState();
    _isSearching = widget.initialSearching;

    if (_isSearching) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _startSearchingSimulation();
        }
      });
    }
  }

  void _startSearchingSimulation() {
    AttemptsTracker.consumeAttempt();
    setState(() {
      _isSearching = true;
      _isResultPlaying = false;
      _resultCurrentSeconds = 8;
    });

    _dotTimer?.cancel();
    _dotTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      if (!mounted) return;
      setState(() {
        _activeDotIndex = (_activeDotIndex + 1) % 3;
      });
    });

    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      _dotTimer?.cancel();
      setState(() {
        _isSearching = false;
      });
    });
  }

  void _toggleUserVoice() {
    setState(() {
      _isUserVoicePlaying = !_isUserVoicePlaying;
      if (_isUserVoicePlaying) {
        _isResultPlaying = false;
        _resultAudioTimer?.cancel();
      }
    });

    if (_isUserVoicePlaying) {
      _userVoiceTimer?.cancel();
      _userVoiceTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          if (_userVoiceSeconds > 1) {
            _userVoiceSeconds--;
          } else {
            _userVoiceSeconds = 6;
            _isUserVoicePlaying = false;
            _userVoiceTimer?.cancel();
          }
        });
      });
    } else {
      _userVoiceTimer?.cancel();
    }
  }

  void _toggleResultAudio() {
    setState(() {
      _isResultPlaying = !_isResultPlaying;
      if (_isResultPlaying) {
        _isUserVoicePlaying = false;
        _userVoiceTimer?.cancel();
      }
    });

    if (_isResultPlaying) {
      _resultAudioTimer?.cancel();
      _resultAudioTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          if (_resultCurrentSeconds < _resultTotalSeconds) {
            _resultCurrentSeconds++;
          } else {
            _resultCurrentSeconds = 8;
            _isResultPlaying = false;
            _resultAudioTimer?.cancel();
          }
        });
      });
    } else {
      _resultAudioTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _dotTimer?.cancel();
    _userVoiceTimer?.cancel();
    _resultAudioTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
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
              // Standard Top Bar
              AppTopBar(
                onProfileTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onNotificationTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),

              // Main chat conversation body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Right-Aligned Headline: "فانكوش بيحضّرك الرد! 🍿"
                      Align(
                        alignment: Alignment.center,
                        child: _buildHeadline(),
                      ),

                      10.verticalSpace,

                      // 2. Right-Aligned User Voice Message Bubble (Figma 1:6590)
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildUserAudioBubble(),
                      ),

                      18.verticalSpace,

                      // 3. AI Content: Searching Card or (Speech Bubble + Audio Result Card)
                      if (_isSearching)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildSearchingCard(),
                        )
                      else ...[
                        // Left-Aligned AI Response Bubble
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildFankoshAiSpeechBubble(),
                        ),

                        16.verticalSpace,

                        // Full-Width Primary Audio Result Card (Figma 1:6636)
                        _buildPrimaryAudioResultCard(),
                      ],

                      16.verticalSpace,
                    ],
                  ),
                ),
              ),

              // Floating Bottom Input Dock
              _buildBottomDock(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Headline (Aligned to Right above user voice)
  // ---------------------------------------------------------------------------
  Widget _buildHeadline() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.fankoshPreparingReply,
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeadingDark,
            ),
          ),
          4.horizontalSpace,
          Text('🍿', style: TextStyle(fontSize: 17.sp)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. User Voice Bubble (Peach/Yellow Container aligned right in RTL)
  // ---------------------------------------------------------------------------
  Widget _buildUserAudioBubble() {
    return Container(
      width: 256.w,
      height: 68.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3D6),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Play / Pause Circle Button on the Right
          GestureDetector(
            onTap: _toggleUserVoice,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isUserVoicePlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                size: 24.sp,
                color: const Color(0xFF815600),
              ),
            ),
          ),

          10.horizontalSpace,

          // Voice Waveform Bars in the center
          Expanded(
            child: SizedBox(
              height: 26.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(_userWaveform.length, (index) {
                  final heightFactor = _userWaveform[index];
                  return Container(
                    width: 3.w,
                    height: (heightFactor * 24.h).clamp(4.h, 24.h),
                    margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF815600),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  );
                }),
              ),
            ),
          ),

          8.horizontalSpace,

          // Duration Label: "00:06" on the Left
          Text(
            _formatTime(_userVoiceSeconds),
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF815600),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Fankoosh AI Speech Bubble (Figma 1:6627 - Aligned Left in RTL)
  // ---------------------------------------------------------------------------
  Widget _buildFankoshAiSpeechBubble() {
    return Container(
      width: 250.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "فانكوش الذكي ✨" Badge
          _buildSmartBadge(),

          10.verticalSpace,

          // Main Catchphrase
          Text(
            AppStrings.caughtEfiehTitle,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 17.5.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1B1C1C),
            ),
          ),

          2.verticalSpace,

          // Subtitle
          Text(
            AppStrings.listenToThisSubtitle,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4E4633),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. Primary Audio Result Card (Figma 1:6636 - Full Width Centerpiece)
  // ---------------------------------------------------------------------------
  Widget _buildPrimaryAudioResultCard() {
    final progress = _resultCurrentSeconds / _resultTotalSeconds;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          // "HQ • 320kbps"
          Text(
            AppStrings.audioQuality,
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF807660),
            ),
          ),

          8.verticalSpace,
          // Audio Player Container with HQ badge and Waveform
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFEBECEF), width: 1),
            ),
            child: Row(
              children: [
                // Play / Pause Round Button on the Right
                GestureDetector(
                  onTap: _toggleResultAudio,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 52.r,
                    height: 52.r,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isResultPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                  ),
                ),

                12.horizontalSpace,

                // Waveform and Duration Timers on the Left
                Expanded(
                  child: Column(
                    children: [
                      // Waveform Bars
                      SizedBox(
                        height: 28.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(_efiehWaveform.length, (
                            index,
                          ) {
                            final barThreshold = index / _efiehWaveform.length;
                            final isPlayed = barThreshold <= progress;
                            final heightFactor = _efiehWaveform[index];

                            return Container(
                              width: 3.5.w,
                              height: (heightFactor * 26.h).clamp(4.h, 26.h),
                              decoration: BoxDecoration(
                                color: isPlayed
                                    ? const Color(0xFFFEC529)
                                    : const Color(0xFFD9DCDF),
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            );
                          }),
                        ),
                      ),

                      4.verticalSpace,

                      // Timers: "00:08" on Left, "00:22" on Right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(_resultTotalSeconds),
                            style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF807660),
                            ),
                          ),
                          Text(
                            _formatTime(_resultCurrentSeconds),
                            style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1B1C1C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          12.verticalSpace,

          // Secondary Action Pill: "خد الإفيه ده عندك! 🎧" (Figma 1:6678)
          GestureDetector(
            onTap: () => _showShareDialog(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 38.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(19.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.volume_up_outlined,
                    size: 18.sp,
                    color: const Color(0xFF807660),
                  ),
                  6.horizontalSpace,
                  Text(
                    AppStrings.takeThisEfieh,
                    style: GoogleFonts.cairo(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4E4633),
                    ),
                  ),
                  6.horizontalSpace,
                  Text('🎧', style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Searching State Card (Figma Frame 8)
  // ---------------------------------------------------------------------------
  Widget _buildSearchingCard() {
    return Container(
      width: 266.w,
      height: 308.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF0EFEA), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Row: "فانكوش الذكي" Badge on Right, "جارٍ التعرف" on Left
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSmartBadge(),
              Text(AppStrings.identifying, style: AppTextStyles.medium11807660),
            ],
          ),

          8.verticalSpace,

          // Title and Subtitle (Aligned to Right)
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.waitTitle,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.bold171B1C1C,
                ),
                2.verticalSpace,
                Text(
                  AppStrings.preparingAwesomeReply,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.regular164E4633,
                ),
              ],
            ),
          ),

          10.verticalSpace,

          // Inner Yellow Finding Box (218x152, #FFC928 with 25% opacity)
          Container(
            width: 218.w,
            height: 152.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC928).withOpacity(0.25),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFFFFC928).withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Search Glass Icon (#815600)
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC928).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    size: 24.sp,
                    color: const Color(0xFF815600),
                  ),
                ),

                8.verticalSpace,

                Text(
                  AppStrings.searchingForEfieh,
                  style: AppTextStyles.semibold141B1C1C,
                ),

                8.verticalSpace,

                // 3 Animated Dots (Primary & #815600)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final isActive = index == _activeDotIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isActive ? 8.r : 6.r,
                      height: isActive ? 8.r : 6.r,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.primary
                            : const Color(0xFF815600),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // "فانكوش الذكي ✨" Badge
  // ---------------------------------------------------------------------------
  Widget _buildSmartBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2C6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFFE082).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            size: 13.sp,
            color: const Color(0xFF815600),
          ),
          4.horizontalSpace,
          Text(
            AppStrings.smartFankosh,
            style: GoogleFonts.cairo(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF815600),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Input Dock (Figma 1:6554: Separate "جارٍ البحث" Container on Right + Dock)
  // ---------------------------------------------------------------------------
  Widget _buildBottomDock() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
      child: Row(
        children: [
          // 1. Separate "جارٍ البحث" pill container on the RIGHT in RTL (when searching)
          if (_isSearching) ...[
            Container(
              width: 72.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: const Color(0xFF43BDFD),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(
                child: Text(
                  AppStrings.searchingInProgress,
                  style: AppTextStyles.medium11White,
                ),
              ),
            ),
            8.horizontalSpace,
          ],

          // 2. The Input Bar container ("قول أي حاجة...")
          Expanded(
            child: Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFFEBECEF), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Right Item in RTL: Yellow Mic Button
                  GestureDetector(
                    onTap: () {
                      if (!AttemptsTracker.hasAttempts) {
                        Navigator.pushNamed(context, AppRoutes.outOfAttempts);
                        return;
                      }
                      _startSearchingSimulation();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mic_none_rounded,
                        size: 20.sp,
                        color: const Color(0xFF1B2230),
                      ),
                    ),
                  ),

                  8.horizontalSpace,

                  // Center: Hint text starting from the right "...قول أي حاجة"
                  Expanded(
                    child: Text(
                      AppStrings.sayAnythingHint,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.regular12807660WithOpacity80,
                    ),
                  ),

                  8.horizontalSpace,

                  // Left Item in RTL: Document / upload icon
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        Icons.insert_drive_file_outlined,
                        size: 20.sp,
                        color: const Color(0xFFB0B5C0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) => const _ShareEfiehDialog(),
    );
  }
}

/// Share Efieh Dialog matching Screenshot (Screen A)
class _ShareEfiehDialog extends StatefulWidget {
  const _ShareEfiehDialog();

  @override
  State<_ShareEfiehDialog> createState() => _ShareEfiehDialogState();
}

class _ShareEfiehDialogState extends State<_ShareEfiehDialog> {
  bool _isPlaying = false;
  Timer? _timer;
  int _seconds = 27;

  // Waveform bars combining user voice (dark) and Fankosh reply (amber)
  static const List<double> _combinedWaveform = [
    0.35, 0.65, 0.85, 0.50, 0.90, 0.40, // Voice bars
    0.60,
    0.80,
    0.95,
    0.70,
    0.55,
    0.85,
    1.00,
    0.75,
    0.60,
    0.85,
    0.70,
    0.95,
    0.65,
    0.45,
    0.35,
    0.25, // Efieh bars
  ];

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!mounted) return;
        setState(() {
          if (_seconds > 1) {
            _seconds--;
          } else {
            _seconds = 27;
            _isPlaying = false;
            _timer?.cancel();
          }
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          width: 335.w,
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row: Close button on Left (in RTL trailing), Share Badge in Center
              Stack(
                alignment: Alignment.center,
                children: [
                  // Centered Share Icon Badge
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF6D9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      size: 22.sp,
                      color: const Color(0xFF765A00),
                    ),
                  ),

                  // Close Button positioned at the top left corner (visual left)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 32.r,
                        height: 32.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEA),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18.sp,
                          color: const Color(0xFF4A454E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              18.verticalSpace,

              // Title: "عجبك رد فانكوش؟ 😂"
              Text(
                AppStrings.didYouLikeFankoshReply,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeadingDark,
                ),
              ),

              4.verticalSpace,

              // Subtitle: "شارك كلامك ورد فانكوش مع صحابك!"
              Text(
                AppStrings.shareVoiceAndFankoshReply,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4A454E),
                ),
              ),

              20.verticalSpace,

              // Audio Preview Container
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF9F5),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFF0EDE4),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  children: [
                    // Top Row: "صوتك + رد فانكوش" on Right, "00:27" on Left
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Right: "صوتك + رد فانكوش" with mic and film icons
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mic_rounded,
                              size: 14.sp,
                              color: const Color(0xFFE5A800),
                            ),
                            2.horizontalSpace,
                            Text(
                              '+',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6B6572),
                              ),
                            ),
                            2.horizontalSpace,
                            Icon(
                              Icons.movie_creation_outlined,
                              size: 14.sp,
                              color: const Color(0xFF6B6572),
                            ),
                            4.horizontalSpace,
                            Text(
                              AppStrings.yourVoicePlusFankosh,
                              style: GoogleFonts.cairo(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6B6572),
                              ),
                            ),
                          ],
                        ),

                        // Left: Duration "00:27"
                        Text(
                          _formatTime(_seconds),
                          style: GoogleFonts.cairo(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF9C9484),
                          ),
                        ),
                      ],
                    ),

                    8.verticalSpace,

                    // Bottom Row: Play Button on Right, Waveform Bars on Left
                    Row(
                      children: [
                        // Yellow Play / Pause Circle Button
                        GestureDetector(
                          onTap: _togglePlay,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 36.r,
                            height: 36.r,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 22.sp,
                              color: const Color(0xFF1B2230),
                            ),
                          ),
                        ),

                        10.horizontalSpace,

                        // Waveform Bars
                        Expanded(
                          child: SizedBox(
                            height: 26.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                _combinedWaveform.length,
                                (index) {
                                  final heightFactor = _combinedWaveform[index];
                                  final isUserVoice = index < 6;
                                  final barColor = isUserVoice
                                      ? const Color(0xFF4A3B2C)
                                      : const Color(0xFFFEC529);

                                  return Container(
                                    width: 3.w,
                                    height: (heightFactor * 24.h).clamp(
                                      4.h,
                                      24.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: barColor,
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              18.verticalSpace,

              // Primary CTA: "شارك القفشة"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (!AttemptsTracker.hasAttempts) {
                    Navigator.pushNamed(context, AppRoutes.outOfAttempts);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share_rounded,
                        size: 18.sp,
                        color: const Color(0xFF150E16),
                      ),
                      8.horizontalSpace,
                      Text(
                        AppStrings.shareEfiehAction,
                        style: GoogleFonts.cairo(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF150E16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              10.verticalSpace,

              // Secondary Button: "مش دلوقتي"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (!AttemptsTracker.hasAttempts) {
                    Navigator.pushNamed(context, AppRoutes.outOfAttempts);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EEEA),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.notNow,
                      style: GoogleFonts.cairo(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B6572),
                      ),
                    ),
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
