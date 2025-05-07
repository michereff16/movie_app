import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficialPageButtonWidget extends StatelessWidget {
  final String officialPageUrl;
  final String buttonTitle;
  const OfficialPageButtonWidget({
    super.key,
    required this.officialPageUrl,
    required this.buttonTitle,
  });

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(officialPageUrl),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [const Color(0xFF3498DB), const Color(0xFF005BB0)],
          ),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
