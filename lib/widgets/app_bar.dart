import 'package:flutter/material.dart';
import 'package:movie_app/services/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
    required this.localeProvider,
    required this.currentLocale,
  });

  final LocaleProvider localeProvider;
  final Locale currentLocale;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String selectedLanguage = 'Português';
  final List<String> languages = ['English', 'Português'];

  @override
  void initState() {
    super.initState();
    selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Image.asset('assets/location.png', height: 16),
                  const SizedBox(width: 4),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      borderRadius: BorderRadius.circular(8),
                      items:
                          languages.map((language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(
                                language,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                      onChanged: (selected) {
                        setState(() {
                          selectedLanguage = selected!;
                          if (selectedLanguage == 'Português') {
                            widget.localeProvider.setLocale(const Locale('pt'));
                          } else {
                            widget.localeProvider.setLocale(const Locale('en'));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/profile.png', height: 40),
        ],
      ),
    );
  }
}
