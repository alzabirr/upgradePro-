import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (_emailController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: AmbientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Icon(CupertinoIcons.chevron_left, color: textDark, size: 28),
              ),
              const SizedBox(height: 40),
              Icon(CupertinoIcons.envelope_open, size: 60, color: primary)
                  .animate()
                  .scale(
                    duration: 500.ms,
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(),
              const SizedBox(height: 24),
              Text(
                _emailSent ? 'Check Your Email' : 'Reset Password',
                style: headingStyle(fontSize: 28, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                _emailSent
                    ? 'We\'ve sent a password reset link to your email address.'
                    : 'Enter your email and we\'ll send you a reset link.',
                style: bodyStyle(color: textMid, fontSize: 15, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              if (!_emailSent) ...[
                CustomTextField(
                  controller: _emailController,
                  placeholder: 'Email address',
                  prefixIcon: CupertinoIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Send Reset Link',
                  isLoading: _isLoading,
                  onPressed: _handleReset,
                ),
              ] else ...[
                Icon(CupertinoIcons.checkmark_circle_fill,
                    size: 80, color: const Color(0xFF34D399))
                    .animate().scale(
                      duration: 500.ms,
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Back to Sign In',
                  isOutlined: true,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
