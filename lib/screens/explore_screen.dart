import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../router/app_router.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final _categories = ['All', 'Work', 'Personal', 'Ideas', 'Health'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    'Explore',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: surface.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: textDark.withValues(alpha: 0.1)),
                    ),
                    child: CupertinoTextField(
                      controller: _searchController,
                      placeholder: 'Search items...',
                      placeholderStyle: bodyStyle(color: textMid, fontSize: 15),
                      style: bodyStyle(color: textDark, fontSize: 15),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Icon(CupertinoIcons.search, color: textMid, size: 20),
                      ),
                      decoration: null,
                      cursorColor: primary,
                      onChanged: (v) {},
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final cat = _categories[i];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: isSelected ? primary : surface.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? primary : textDark.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: bodyStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : textDark,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(8, (i) => _ExploreItem(
                title: 'Item ${i + 1}',
                subtitle: _categories[i % _categories.length],
                index: i,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExploreItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;

  const _ExploreItem({required this.title, required this.subtitle, required this.index});

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
                color: nodeColors[index % nodeColors.length].withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                CupertinoIcons.doc_text,
                color: nodeColors[index % nodeColors.length],
                size: 24,
              ),
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
    ).animate().fadeIn(delay: Duration(milliseconds: 50 * index));
  }
}
