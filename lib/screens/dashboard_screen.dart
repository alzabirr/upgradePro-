import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../router/app_router.dart';
import '../storage/hive_storage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _storage = HiveStorage();
  late String _userName;

  @override
  void initState() {
    super.initState();
    _userName = _storage.getSetting('profileName', 'User') as String;
  }

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
                    'Dashboard',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Hello, $_userName',
                style: headingStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                "Here's your overview",
                style: bodyStyle(color: textMid, fontSize: 15),
              ),
              const SizedBox(height: 24),
              _StatsRow(),
              const SizedBox(height: 24),
              _QuickActions(),
              const SizedBox(height: 24),
              Text(
                'Recent Activity',
                style: headingStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _ActivityCard(
                icon: CupertinoIcons.plus_circle,
                title: 'Created new item',
                subtitle: '2 minutes ago',
              ),
              _ActivityCard(
                icon: CupertinoIcons.heart,
                title: 'Added to favorites',
                subtitle: '1 hour ago',
              ),
              _ActivityCard(
                icon: CupertinoIcons.gear,
                title: 'Updated settings',
                subtitle: 'Yesterday',
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
    return Row(
      children: [
        Expanded(child: _StatCard(label: 'Items', value: '12', color: primary)),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(label: 'Favorites', value: '3', color: const Color(0xFFF472B6))),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(label: 'Categories', value: '5', color: const Color(0xFF34D399))),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surface.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: textDark.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: headingStyle(fontSize: 28, fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 4),
              Text(label, style: bodyStyle(color: textMid, fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    ).animate().fadeIn();
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionCard(
          icon: CupertinoIcons.plus,
          label: 'New Item',
          onTap: () => Navigator.pushNamed(context, AppRouter.createItem),
        ),
        const SizedBox(width: 12),
        _ActionCard(
          icon: CupertinoIcons.compass,
          label: 'Explore',
          onTap: () => Navigator.pushNamed(context, AppRouter.explore),
        ),
        const SizedBox(width: 12),
        _ActionCard(
          icon: CupertinoIcons.heart,
          label: 'Favorites',
          onTap: () => Navigator.pushNamed(context, AppRouter.favorites),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: surface.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: textDark.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  Icon(icon, color: primary, size: 28),
                  const SizedBox(height: 8),
                  Text(label, style: bodyStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn();
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActivityCard({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: Row(
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
                Text(title, style: bodyStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: bodyStyle(color: textMid, fontSize: 13)),
              ],
            ),
          ),
          Icon(CupertinoIcons.chevron_forward, color: textMid, size: 16),
        ],
      ),
    );
  }
}
