import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: AmbientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(44, 44),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(CupertinoIcons.chevron_left, color: textDark, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Terms & Privacy',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _Section(
                title: 'Terms of Service',
                content: 'By using this application, you agree to the following terms:\n\n'
                    '1. You will use the app for lawful purposes only.\n\n'
                    '2. You are responsible for maintaining the confidentiality of your account.\n\n'
                    '3. We reserve the right to modify or discontinue the service at any time.\n\n'
                    '4. We are not liable for any damages arising from your use of the app.\n\n'
                    '5. These terms may be updated from time to time without prior notice.',
              ),
              const SizedBox(height: 20),
              _Section(
                title: 'Privacy Policy',
                content: 'Your privacy is important to us:\n\n'
                    '1. Data Storage: All data is stored locally on your device using Hive.\n\n'
                    '2. No Tracking: We do not collect or track your personal data.\n\n'
                    '3. Cloud Sync: If enabled, data is synced to your personal cloud storage only.\n\n'
                    '4. No Third Parties: We do not share your data with third parties.\n\n'
                    '5. You can delete all your data at any time from the app settings.',
              ),
              const SizedBox(height: 20),
              _Section(
                title: 'Data Collection',
                content: 'This app collects minimal data:\n\n'
                    '- Display name and email (provided by you)\n'
                    '- App preferences (dark mode, theme, notifications)\n'
                    '- Created content (items, notes, etc.)\n\n'
                    'All data remains on your device unless cloud sync is enabled.',
              ),
              const SizedBox(height: 24),
              Text(
                'Last updated: January 2025',
                style: bodyStyle(color: textMid, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;
  const _Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Text(content, style: bodyStyle(color: textMid, fontSize: 14, height: 1.7)),
        ],
      ),
    );
  }
}
