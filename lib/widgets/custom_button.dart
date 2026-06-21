import 'dart:ui';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(buttonRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: width ?? double.infinity,
            height: 54,
            decoration: BoxDecoration(
              color: isOutlined
                  ? Colors.transparent
                  : primary.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(buttonRadius),
              border: isOutlined
                  ? Border.all(color: primary.withValues(alpha: 0.5), width: 1.5)
                  : null,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: isOutlined ? primary : Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: isOutlined ? primary : Colors.white, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          label,
                          style: bodyStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isOutlined ? primary : Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
