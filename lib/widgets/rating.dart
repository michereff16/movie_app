import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating, required this.votes});

  final double rating;
  final int votes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 24),
        const SizedBox(width: 8),
        Text(
          rating.toString().substring(0, 3),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$votes ${AppLocalizations.of(context)!.votes}',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
