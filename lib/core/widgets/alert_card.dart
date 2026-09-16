import 'package:flutter/material.dart';
import 'package:stable_vitals/core/constants/app_colors.dart';
import 'package:stable_vitals/models/alert.dart';
import 'package:stable_vitals/models/horse.dart';
import 'status_badge.dart';

class AlertCard extends StatelessWidget {
  final HorseAlert alert;
  final VoidCallback? onTap;

  const AlertCard({
    super.key,
    required this.alert,
    this.onTap,
  });

  Color get accentColor {
    return alert.severity == AlertSeverity.urgent
        ? AppColors.urgent
        : AppColors.check;
  }

  Color get backgroundColor {
    return alert.severity == AlertSeverity.urgent
        ? AppColors.urgentBackground
        : AppColors.checkBackground;
  }

  HorseStatus get horseStatus {
    return alert.severity == AlertSeverity.urgent
        ? HorseStatus.urgent
        : HorseStatus.check;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  alert.severity ==
                          AlertSeverity.urgent
                      ? Icons.priority_high_rounded
                      : Icons.visibility_outlined,
                  color: accentColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            alert.horse.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          ),
                        ),

                        StatusBadge(
                          status: horseStatus,
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Text(
                      alert.message,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Text(
                          'Stall ${alert.horse.stall}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),

                        const SizedBox(width: 10),

                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.textMuted,
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          _formatTime(alert.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute =
        dateTime.minute.toString().padLeft(2, '0');

    final period = hour >= 12 ? 'PM' : 'AM';

    final displayHour =
        hour % 12 == 0 ? 12 : hour % 12;

    return '$displayHour:$minute $period';
  }
}