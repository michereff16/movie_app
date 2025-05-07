import 'package:flutter/material.dart';
import 'package:movie_app/view_models/home_view_model.dart';
import 'package:movie_app/widgets/tab_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabButtonWidget(
            index: 0,
            label: AppLocalizations.of(context)!.nowPlaying,
            viewModel: viewModel,
          ),
          const SizedBox(width: 16),
          TabButtonWidget(
            index: 1,
            label: AppLocalizations.of(context)!.upcoming,
            viewModel: viewModel,
          ),
        ],
      ),
    );
  }
}
