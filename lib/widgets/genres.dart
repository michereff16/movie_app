import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({super.key, required this.genres});

  final List<String>? genres;

  @override
  Widget build(BuildContext context) {
    final error = AppLocalizations.of(context)!.nA;
    final genreList = genres ?? [error];
    return Text(
      genreList.join('; '),
      style: const TextStyle(
        color: Colors.white70,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
