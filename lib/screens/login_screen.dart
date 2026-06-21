import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';
import '../widgets/ambient_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
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
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 60),
              Icon(CupertinoIcons.lock_fill, size: 60, color: primary)
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
                'Welcome Back',
                style: headingStyle(fontSize: 30, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: bodyStyle(color: textMid, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      placeholder: 'Email address',
                      prefixIcon: CupertinoIcons.mail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      placeholder: 'Password',
                      prefixIcon: CupertinoIcons.lock,
                      obscure: _obscurePassword,
                      suffix: GestureDetector(
                        onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        child: Icon(
                          _obscurePassword
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          color: textMid,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRouter.forgotPassword),
                  child: Text(
                    'Forgot password?',
                    style: bodyStyle(color: primary, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: 'Sign In',
                isLoading: _isLoading,
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: bodyStyle(color: textMid, fontSize: 14)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRouter.signup),
                    child: Text(
                      'Sign Up',
                      style: bodyStyle(color: primary, fontSize: 14, fontWeight: FontWeight.w600),
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
