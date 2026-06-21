import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../widgets/avatar.dart';
import '../router/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                    'Profile',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: AppAvatar(
                  initials: 'SU',
                  size: 96,
                  onTap: () => Navigator.pushNamed(context, AppRouter.editProfile),
                ),
              ).animate().scale(
                    duration: 500.ms,
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Starter User',
                  style: headingStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'user@example.com',
                  style: bodyStyle(color: textMid, fontSize: 15),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRouter.editProfile),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: bodyStyle(color: primary, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _StatsRow(),
              const SizedBox(height: 24),
              _ProfileSection(
                title: 'Account',
                items: [
                  _ProfileItem(icon: CupertinoIcons.person, title: 'Edit Profile', onTap: () => Navigator.pushNamed(context, AppRouter.editProfile)),
                  _ProfileItem(icon: CupertinoIcons.bell, title: 'Notifications', onTap: () => Navigator.pushNamed(context, AppRouter.notifications)),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (_) => false);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Out',
                      style: bodyStyle(color: const Color(0xFFEF4444), fontSize: 16, fontWeight: FontWeight.w600),
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

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(value: '12', label: 'Items'),
          _StatItem(value: '3', label: 'Favorites'),
          _StatItem(value: '5', label: 'Categories'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: headingStyle(fontSize: 22, fontWeight: FontWeight.w700, color: primary)),
        const SizedBox(height: 4),
        Text(label, style: bodyStyle(color: textMid, fontSize: 13)),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<_ProfileItem> items;
  const _ProfileSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: bodyStyle(fontSize: 13, color: textMid, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _ProfileItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: primary, size: 20),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: bodyStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            Icon(CupertinoIcons.chevron_forward, color: textMid, size: 16),
          ],
        ),
      ),
    );
  }
}
