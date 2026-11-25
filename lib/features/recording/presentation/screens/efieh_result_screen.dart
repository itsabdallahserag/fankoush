import 'package:flutter/material.dart';
import 'package:fankoush/features/recording/presentation/screens/finding_efieh_screen.dart';

/// Screen representing the Efieh result.
/// Forwards directly to [FindingEfiehScreen] in the result state (`initialSearching: false`).
class EfiehResultScreen extends StatelessWidget {
  final String movieTitle;
  final String characterName;
  final String jokeText;

  const EfiehResultScreen({
    super.key,
    this.movieTitle = 'فيلم الناظر',
    this.characterName = 'علاء ولي الدين (اللمبي والناظر)',
    this.jokeText = '«يا عم ما تبصلهاش كده، دي بتتحرج!»',
  });

  @override
  Widget build(BuildContext context) {
    return const FindingEfiehScreen(initialSearching: false);
  }
}
