import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../storage/hive_storage.dart';
import '../utils/extensions.dart';
import '../widgets/ambient_background.dart';
import '../router/app_router.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgLight,
      body: AmbientBackground(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  if (_currentIndex == 0) _buildTopBar(),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (i) => setState(() => _currentIndex = i),
                      children: [
                        _buildHomeTab(),
                        _buildExploreTab(),
                        _buildCreateTab(),
                        _buildFavoritesTab(),
                        _buildSettingsTab(),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                left: 20,
                right: 20,
                child: _buildBottomNavBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: surface.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: textDark.withValues(alpha: 0.15), width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.search, color: textMid, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CupertinoTextField(
                          placeholder: 'Search...',
                          placeholderStyle: bodyStyle(color: textDark.withValues(alpha: 0.4), fontSize: 16, fontWeight: FontWeight.w400),
                          style: bodyStyle(color: textDark, fontSize: 16, fontWeight: FontWeight.w400),
                          decoration: null,
                          cursorColor: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRouter.notifications),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: surface.withValues(alpha: 0.55),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1),
                  ),
                  child: Center(
                    child: Icon(CupertinoIcons.bell, color: textDark, size: 23),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color: surface.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: textDark.withValues(alpha: 0.15), width: 1),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 10)),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavBarItem(0, CupertinoIcons.home),
              _buildNavBarItem(1, CupertinoIcons.compass),
              _buildNavBarItem(2, CupertinoIcons.add),
              _buildNavBarItem(3, CupertinoIcons.heart),
              _buildNavBarItem(4, CupertinoIcons.settings),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? (isDarkMode ? Colors.white : const Color(0xFF1C1C1E)) : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          icon,
          color: isSelected ? (isDarkMode ? const Color(0xFF121212) : Colors.white) : textDark.withValues(alpha: 0.4),
          size: index == 2 ? 28 : 23,
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 72),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.rocket_fill, color: primary.withValues(alpha: 0.8), size: 80)
                      .animate()
                      .slideY(begin: 0.5, end: 0, duration: 600.ms, curve: Curves.easeOutBack)
                      .fadeIn(),
                  const SizedBox(height: 24),
                  Text('Welcome to Upgrade', style: headingStyle(fontSize: 24, color: textDark))
                      .animate()
                      .fadeIn(delay: 300.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 12),
                  Text(
                    'Your new Flutter app is ready.\nStart building something amazing!',
                    textAlign: TextAlign.center,
                    style: bodyStyle(color: textMid, fontSize: 16, height: 1.5),
                  ).animate().fadeIn(delay: 500.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTab() {
    final categories = ['All', 'Work', 'Personal', 'Ideas', 'Health'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text('Explore', style: headingStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: surface.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: textDark.withValues(alpha: 0.15), width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.search, color: textMid, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CupertinoTextField(
                        placeholder: 'Search...',
                        placeholderStyle: bodyStyle(color: textDark.withValues(alpha: 0.4), fontSize: 16, fontWeight: FontWeight.w400),
                        style: bodyStyle(color: textDark, fontSize: 16, fontWeight: FontWeight.w400),
                        decoration: null,
                        cursorColor: primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final cat = categories[i];
                final isSelected = i == 0;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected ? primary : surface.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isSelected ? primary : textDark.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.white, size: 16),
                        ),
                      Text(cat, style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : textDark)),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(8, (i) => _ExploreItem(title: 'Item ${i + 1}', subtitle: categories[i % categories.length], index: i)),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    final categories = ['General', 'Work', 'Personal', 'Ideas', 'Health', 'Finance'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text('New Item', style: headingStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          _buildLabel('Title'),
          const SizedBox(height: 10),
          _buildCreateTextField('Enter title'),
          const SizedBox(height: 20),
          _buildLabel('Description'),
          const SizedBox(height: 10),
          _buildCreateTextField('Enter description', maxLines: 4),
          const SizedBox(height: 20),
          _buildLabel('Category'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((cat) {
              final isSelected = cat == 'General';
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? primary : surface.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isSelected ? primary : textDark.withValues(alpha: 0.1)),
                ),
                child: Text(cat, style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : textDark)),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => context.showAppSnackBar('Item created successfully'),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text('Save', style: bodyStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textMid));
  }

  Widget _buildCreateTextField(String hint, {int maxLines = 1}) {
    return ClipRRect(
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
            placeholder: hint,
            placeholderStyle: bodyStyle(color: textMid, fontSize: 15),
            style: bodyStyle(color: textDark, fontSize: 15),
            padding: const EdgeInsets.all(16),
            decoration: null,
            maxLines: maxLines,
            cursorColor: primary,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text('Favorites', style: headingStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          ...List.generate(3, (i) => _FavoriteItem(title: 'Favorite Item ${i + 1}', subtitle: 'Tap to view details', index: i)),
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                Icon(CupertinoIcons.heart_slash, size: 60, color: primary.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text('No more favorites', style: bodyStyle(color: textMid, fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text('Settings', style: headingStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          _SettingsGroup(
            children: [
              _SettingsTile(icon: CupertinoIcons.person_crop_circle, title: 'Profile', onTap: () => Navigator.pushNamed(context, AppRouter.profile)),
            ],
          ),
          const SizedBox(height: 18),
          _SettingsGroup(
            children: [
              _DarkModeTile(),
              _Divider(),
              _NotificationsTile(),
            ],
          ),
          const SizedBox(height: 18),
          _SettingsGroup(
            children: [
              _SettingsTile(icon: CupertinoIcons.lock_shield, title: 'Privacy Policy', onTap: () => Navigator.pushNamed(context, AppRouter.terms)),
              _Divider(),
              _SettingsTile(icon: CupertinoIcons.question_circle, title: 'Help & FAQ', onTap: () => Navigator.pushNamed(context, AppRouter.help)),
              _Divider(),
              _SettingsTile(icon: CupertinoIcons.info_circle, title: 'About', onTap: () => Navigator.pushNamed(context, AppRouter.about)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: textDark.withValues(alpha: 0.06)),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(height: 1, color: textDark.withValues(alpha: 0.07)),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              child: Text(title, style: bodyStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            Icon(CupertinoIcons.chevron_forward, color: textMid, size: 16),
          ],
        ),
      ),
    );
  }
}

class _DarkModeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: darkModeNotifier,
      builder: (context, isDark, _) {
        return GestureDetector(
          onTap: () async {
            darkModeNotifier.value = !isDark;
            await HiveStorage().saveSetting('darkMode', !isDark);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(CupertinoIcons.moon, color: primary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text('Dark Mode', style: bodyStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                CupertinoSwitch(
                  value: isDark,
                  activeTrackColor: primary,
                  onChanged: (val) async {
                    darkModeNotifier.value = val;
                    await HiveStorage().saveSetting('darkMode', val);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotificationsTile extends StatefulWidget {
  const _NotificationsTile();

  @override
  State<_NotificationsTile> createState() => _NotificationsTileState();
}

class _NotificationsTileState extends State<_NotificationsTile> {
  late bool _enabled;
  final _storage = HiveStorage();

  @override
  void initState() {
    super.initState();
    _enabled = _storage.getSetting('notificationsEnabled', true) as bool;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() => _enabled = !_enabled);
        await _storage.saveSetting('notificationsEnabled', _enabled);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(CupertinoIcons.bell, color: primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text('Notifications', style: bodyStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            CupertinoSwitch(
              value: _enabled,
              activeTrackColor: primary,
              onChanged: (val) async {
                setState(() => _enabled = val);
                await _storage.saveSetting('notificationsEnabled', val);
              },
            ),
          ],
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
              child: Icon(CupertinoIcons.doc_text, color: nodeColors[index % nodeColors.length], size: 24),
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

class _FavoriteItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;
  const _FavoriteItem({required this.title, required this.subtitle, required this.index});

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
