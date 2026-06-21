import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../storage/hive_storage.dart';
import '../router/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final _pages = const [
    _OnboardingPage(
      icon: CupertinoIcons.sparkles,
      title: 'Welcome to Upgrade',
      subtitle: 'A beautifully crafted Flutter starter kit\nto build amazing apps faster.',
    ),
    _OnboardingPage(
      icon: CupertinoIcons.paintbrush,
      title: 'Beautiful Design',
      subtitle: 'Glassmorphic UI, dark mode, and\ncustomizable themes out of the box.',
    ),
    _OnboardingPage(
      icon: CupertinoIcons.cloud,
      title: 'Ready to Scale',
      subtitle: 'Offline storage, cloud sync ready,\nand clean architecture built in.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    final storage = HiveStorage();
    await storage.saveSetting('onboardingSeen', true);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: AmbientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CupertinoButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    'Skip',
                    style: bodyStyle(color: textMid, fontSize: 15),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (_, i) => _pages[i],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentPage == i ? 28 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentPage == i ? primary : textMid.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: GestureDetector(
                  onTap: _nextPage,
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: bodyStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: primary)
              .animate()
              .scale(
                duration: 600.ms,
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                curve: Curves.easeOutBack,
              )
              .fadeIn(),
          const SizedBox(height: 40),
          Text(
            title,
            style: headingStyle(fontSize: 28, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: bodyStyle(color: textMid, fontSize: 16, height: 1.5),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
