import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';

/// Reusable Audio Waveform widget for live recording and playback preview.
class AudioWaveform extends StatelessWidget {
  final List<double> levels;
  final double progress;
  final bool reverse;
  final double? height;
  final double? barWidth;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? playheadColor;

  const AudioWaveform({
    super.key,
    required this.levels,
    this.progress = 0.0,
    this.reverse = false,
    this.height,
    this.barWidth,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.playheadColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 110.h;
    final effectiveBarWidth = barWidth ?? 3.5.w;
    final effectiveGap = gap ?? 2.5.w;
    final effectiveActive = activeColor ?? AppColors.primary;
    final effectiveInactive = inactiveColor ?? const Color(0xFFE5E7EB);

    return SizedBox(
      height: effectiveHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (levels.isEmpty) {
            return const SizedBox.shrink();
          }

          final maxVisibleBars =
              (constraints.maxWidth / (effectiveBarWidth + effectiveGap)).floor();
          final visibleCount =
              levels.length > maxVisibleBars ? maxVisibleBars : levels.length;
          final startIdx =
              levels.length > visibleCount ? levels.length - visibleCount : 0;
          final displayLevels = levels.sublist(startIdx);

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(displayLevels.length, (index) {
              final normalizedIndex = reverse
                  ? (displayLevels.length - 1 - index)
                  : index;
              final currentProgressThreshold =
                  normalizedIndex / displayLevels.length;
              final isPlayed = currentProgressThreshold <= progress;

              final amp = displayLevels[index].clamp(0.08, 1.0);
              final barH = (amp * effectiveHeight).clamp(6.h, effectiveHeight);

              final Color color = progress > 0
                  ? (isPlayed ? effectiveActive : effectiveInactive)
                  : effectiveActive;

              return Container(
                width: effectiveBarWidth,
                height: barH,
                margin: EdgeInsets.symmetric(horizontal: effectiveGap / 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(effectiveBarWidth / 2),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
