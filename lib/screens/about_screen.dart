import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                    'About',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primary, accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(CupertinoIcons.rocket_fill, color: Colors.white, size: 48),
                ),
              ).animate().scale(
                    duration: 500.ms,
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Upgrade Starter Kit',
                  style: headingStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: bodyStyle(color: textMid, fontSize: 15),
                ),
              ),
              const SizedBox(height: 32),
              _InfoCard(
                title: 'About this app',
                body: 'Upgrade Starter Kit is a beautifully crafted Flutter boilerplate with glassmorphic UI, dark mode, offline storage, and clean architecture — ready for you to build amazing apps.',
              ),
              const SizedBox(height: 14),
              _InfoCard(
                title: 'Features',
                body: '• Glassmorphic UI design\n• Dark & Light mode\n• Offline Hive storage\n• Provider state management\n• Clean architecture\n• Reusable widgets',
              ),
              const SizedBox(height: 14),
              _InfoCard(
                title: 'Credits',
                body: 'Built with Flutter, Dart, Provider, Hive, Google Fonts, and Flutter Animate.',
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Made with Flutter',
                  style: bodyStyle(color: textMid, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;
  const _InfoCard({required this.title, required this.body});

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
          Text(title, style: headingStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text(body, style: bodyStyle(color: textMid, fontSize: 14, height: 1.6)),
        ],
      ),
    );
  }
}
