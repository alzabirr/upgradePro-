import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../storage/hive_storage.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final _storage = HiveStorage();
  late String _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = _storage.getSetting('themeName', 'Ocean') as String;
  }

  Future<void> _selectTheme(String name) async {
    setState(() => _selectedTheme = name);
    await _storage.saveSetting('themeName', name);
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
                    'Theme',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Choose your palette',
                style: bodyStyle(color: textMid, fontSize: 15),
              ),
              const SizedBox(height: 20),
              ...themePalettes.entries.map((entry) {
                final isSelected = _selectedTheme == entry.key;
                return GestureDetector(
                  onTap: () => _selectTheme(entry.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surface.withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? primary : textDark.withValues(alpha: 0.06),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          entry.key,
                          style: bodyStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: entry.value.map((color) => Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(left: 6),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          )).toList(),
                        ),
                        const SizedBox(width: 12),
                        if (isSelected)
                          Icon(CupertinoIcons.checkmark_circle_fill, color: primary, size: 22)
                        else
                          Icon(CupertinoIcons.circle, color: textMid, size: 22),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
