import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
                    'Notifications',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text('Mark all read', style: bodyStyle(color: primary, fontSize: 13, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _NotificationCard(
                icon: CupertinoIcons.sparkles,
                title: 'Welcome to Upgrade',
                subtitle: 'Your starter kit is ready. Start building amazing apps!',
                time: 'Just now',
                isUnread: true,
              ),
              _NotificationCard(
                icon: CupertinoIcons.paintbrush,
                title: 'Theme Updated',
                subtitle: 'Try the new glassmorphic UI theme.',
                time: '2h ago',
                isUnread: true,
              ),
              _NotificationCard(
                icon: CupertinoIcons.cloud,
                title: 'Cloud Sync Available',
                subtitle: 'Enable cloud sync to backup your data.',
                time: '1d ago',
                isUnread: false,
              ),
              const SizedBox(height: 40),
              EmptyState(
                icon: CupertinoIcons.bell_slash,
                title: 'No more notifications',
                subtitle: 'You\'re all caught up!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;

  const _NotificationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUnread ? primary.withValues(alpha: 0.3) : textDark.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: bodyStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: bodyStyle(color: textMid, fontSize: 13, height: 1.4)),
                const SizedBox(height: 6),
                Text(time, style: bodyStyle(color: textMid, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}
