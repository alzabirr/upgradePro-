import 'package:flutter/cupertino.dart';
import '../utils/extensions.dart';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../storage/hive_storage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _storage = HiveStorage();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = _storage.getSetting('profileName', 'Starter User') as String;
    _bioController.text = _storage.getSetting('userBio', 'Flutter developer') as String;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    await _storage.saveSetting('profileName', _nameController.text.trim());
    await _storage.saveSetting('userBio', _bioController.text.trim());
    setState(() => _isLoading = false);
    if (mounted) {
      context.showAppSnackBar('Profile updated');
      Navigator.pop(context);
    }
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
                    'Edit Profile',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [primary, accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(CupertinoIcons.person_fill, color: Colors.white, size: 44),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: bgLight, width: 3),
                        ),
                        child: const Icon(CupertinoIcons.camera_fill, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('Name', style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textMid)),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _nameController,
                placeholder: 'Your name',
                prefixIcon: CupertinoIcons.person,
              ),
              const SizedBox(height: 20),
              Text('Bio', style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textMid)),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _bioController,
                placeholder: 'Tell us about yourself',
                prefixIcon: CupertinoIcons.text_quote,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              CustomButton(
                label: 'Save Changes',
                isLoading: _isLoading,
                onPressed: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
