import 'package:flutter/material.dart';
import 'package:stable_vitals/core/constants/app_colors.dart';
import 'package:stable_vitals/models/horse.dart';

class StatusBadge extends StatelessWidget {
  final HorseStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  String get label {
    switch (status) {
      case HorseStatus.urgent:
        return 'URGENT';

      case HorseStatus.check:
        return 'CHECK';

      case HorseStatus.onTrack:
        return 'ON TRACK';
    }
  }

  Color get foregroundColor {
    switch (status) {
      case HorseStatus.urgent:
        return AppColors.urgent;

      case HorseStatus.check:
        return AppColors.check;

      case HorseStatus.onTrack:
        return AppColors.onTrack;
    }
  }

  Color get backgroundColor {
    switch (status) {
      case HorseStatus.urgent:
        return AppColors.urgentBackground;

      case HorseStatus.check:
        return AppColors.checkBackground;

      case HorseStatus.onTrack:
        return AppColors.onTrackBackground;
    }
  }

  IconData get icon {
    switch (status) {
      case HorseStatus.urgent:
        return Icons.priority_high_rounded;

      case HorseStatus.check:
        return Icons.remove_circle_outline_rounded;

      case HorseStatus.onTrack:
        return Icons.check_circle_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: foregroundColor,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: .4,
            ),
          ),
        ],
      ),
    );
  }
}