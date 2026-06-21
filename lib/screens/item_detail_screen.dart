import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';

class ItemDetailScreen extends StatelessWidget {
  final String? itemId;
  const ItemDetailScreen({super.key, this.itemId});

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
                    'Item Detail',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Icon(CupertinoIcons.ellipsis, color: textDark, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary.withValues(alpha: 0.3), accent.withValues(alpha: 0.3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Icon(CupertinoIcons.doc_text_fill, size: 64, color: primary.withValues(alpha: 0.7)),
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
              Text(
                'Sample Item',
                style: headingStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 8),
              Row(
                children: [
                  _Tag(label: 'Work'),
                  const SizedBox(width: 8),
                  _Tag(label: 'Important'),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'This is a detailed view of the item. You can add more information, images, and actions here. The glassmorphic UI provides a clean, modern look that works across both light and dark modes.',
                style: bodyStyle(color: textMid, fontSize: 15, height: 1.6),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 32),
              _DetailRow(icon: CupertinoIcons.calendar, label: 'Created', value: 'Today'),
              _DetailRow(icon: CupertinoIcons.tag, label: 'Category', value: 'Work'),
              _DetailRow(icon: CupertinoIcons.clock, label: 'Updated', value: '2 min ago'),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: CupertinoIcons.pencil,
                      label: 'Edit',
                      color: primary,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: CupertinoIcons.heart,
                      label: 'Favorite',
                      color: const Color(0xFFF472B6),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: CupertinoIcons.share,
                      label: 'Share',
                      color: const Color(0xFF34D399),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: bodyStyle(color: primary, fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primary, size: 20),
          const SizedBox(width: 12),
          Text(label, style: bodyStyle(color: textMid, fontSize: 14, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(label, style: bodyStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}
