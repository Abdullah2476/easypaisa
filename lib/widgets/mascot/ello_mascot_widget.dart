import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Ello Mascot Widget (Clean Standard Flutter Widget)
/// Displays a friendly yellow avatar / placeholder badge without custom painter.
class ElloMascotWidget extends StatelessWidget {
  final double size;
  final bool showAvatarOnly;

  const ElloMascotWidget({
    super.key,
    this.size = 60,
    this.showAvatarOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showAvatarOnly) {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF176), Color(0xFFFFD600)],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.sentiment_very_satisfied_rounded,
            size: size * 0.75,
            color: const Color(0xFF222B33),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mascotYellow,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.face_rounded,
          size: size * 0.7,
          color: const Color(0xFF222B33),
        ),
      ),
    );
  }
}
