import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../widgets/empty_state.dart';
import '../router/app_router.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
                    'Favorites',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...List.generate(3, (i) => _FavoriteCard(
                title: 'Favorite Item ${i + 1}',
                subtitle: 'Tap to view details',
                index: i,
              )),
              const SizedBox(height: 40),
              EmptyState(
                icon: CupertinoIcons.heart_slash,
                title: 'No more favorites',
                subtitle: 'Items you favorite will appear here.',
                actionLabel: 'Explore Items',
                onAction: () => Navigator.pushNamed(context, AppRouter.explore),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;

  const _FavoriteCard({required this.title, required this.subtitle, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouter.itemDetail, arguments: '$index'),
      child: Container(
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
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFF472B6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(CupertinoIcons.heart_fill, color: Color(0xFFF472B6), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: bodyStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: bodyStyle(color: textMid, fontSize: 13)),
                ],
              ),
            ),
            Icon(CupertinoIcons.chevron_forward, color: textMid, size: 16),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 80 * index));
  }
}
