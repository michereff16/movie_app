import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummarySectionWidget extends StatelessWidget {
  const SummarySectionWidget({super.key, required this.summary});

  final String? summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.overview,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(summary ?? '[...]', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
