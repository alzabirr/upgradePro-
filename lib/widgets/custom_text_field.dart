import 'dart:ui';
import 'package:flutter/cupertino.dart';
import '../themes/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.prefixIcon,
    this.suffix,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: surface.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: textDark.withValues(alpha: 0.1), width: 1),
          ),
          child: CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            placeholderStyle: bodyStyle(
              color: textMid,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            style: bodyStyle(
              color: textDark,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            prefix: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Icon(prefixIcon, color: textMid, size: 20),
                  )
                : null,
            suffix: suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: suffix,
                  )
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: null,
            obscureText: obscure,
            keyboardType: keyboardType,
            maxLines: maxLines,
            cursorColor: primary,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
