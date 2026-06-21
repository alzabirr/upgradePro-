import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
                    'Help & FAQ',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _FaqItem(
                question: 'How do I add a new item?',
                answer: 'Tap the "+" button in the bottom navigation bar or the "New Item" card on the dashboard. Fill in the details and tap Save.',
              ),
              _FaqItem(
                question: 'How do I enable dark mode?',
                answer: 'Go to Settings > App > Dark Mode toggle. The change applies instantly across the entire app.',
              ),
              _FaqItem(
                question: 'Is my data backed up?',
                answer: 'Data is stored locally on your device using Hive. Enable Cloud Sync in Settings for automatic backups.',
              ),
              _FaqItem(
                question: 'How do I change the theme?',
                answer: 'Go to Profile > Theme to choose from 8 pre-built color palettes.',
              ),
              _FaqItem(
                question: 'How do I contact support?',
                answer: 'Send an email to support@example.com and we\'ll get back to you within 24 hours.',
              ),
              const SizedBox(height: 32),
              Text(
                'Still need help?',
                style: headingStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Contact Support',
                      style: bodyStyle(color: primary, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.question_circle_fill, color: primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: bodyStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              answer,
              style: bodyStyle(color: textMid, fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
