import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 48,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [primary, accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: imageUrl != null
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _buildFallback(),
              ),
            )
          : _buildFallback(),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }

  Widget _buildFallback() {
    return Center(
      child: Text(
        initials ?? '?',
        style: bodyStyle(
          fontSize: size * 0.35,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
