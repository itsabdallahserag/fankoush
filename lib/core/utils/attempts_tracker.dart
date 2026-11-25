import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Tracks the user's free attempts count across the app.
/// Initial: 3 free attempts.
/// When user exhausts 3 attempts (remaining == 0), the app navigates
/// to [OutOfAttemptsScreen] ("القفشات ببلاش خلصت!").
class AttemptsTracker {
  AttemptsTracker._();

  static const int maxFreeAttempts = 3;
  static final ValueNotifier<int> attemptsNotifier =
      ValueNotifier<int>(maxFreeAttempts);

  static int get remainingAttempts => attemptsNotifier.value;
  static bool get hasAttempts => remainingAttempts > 0;

  /// Consumes 1 attempt safely outside the widget build phase.
  /// Returns false if already out of attempts.
  static bool consumeAttempt() {
    if (attemptsNotifier.value > 0) {
      if (WidgetsBinding.instance.schedulerPhase ==
          SchedulerPhase.persistentCallbacks) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (attemptsNotifier.value > 0) {
            attemptsNotifier.value--;
          }
        });
      } else {
        attemptsNotifier.value--;
      }
      return true;
    }
    return false;
  }

  /// Resets attempts (e.g. on new day or plan purchase).
  static void reset([int count = maxFreeAttempts]) {
    attemptsNotifier.value = count;
  }
}
