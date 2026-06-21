import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../utils/extensions.dart';

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'General';
  final _categories = ['General', 'Work', 'Personal', 'Ideas', 'Health', 'Finance'];
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_titleController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
    if (mounted) {
      context.showAppSnackBar('Item created successfully');
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
                    'New Item',
                    style: headingStyle(fontSize: 18, color: textDark),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _isLoading ? null : _handleSave,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text('Save', style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildLabel('Title'),
              const SizedBox(height: 10),
              _buildTextField(_titleController, 'Enter title'),
              const SizedBox(height: 24),
              _buildLabel('Description'),
              const SizedBox(height: 10),
              _buildTextField(_descController, 'Enter description', maxLines: 4),
              const SizedBox(height: 24),
              _buildLabel('Category'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? primary : surface.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? primary : textDark.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        cat,
                        style: bodyStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : textDark,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textMid));
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
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
            controller: controller,
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
}
