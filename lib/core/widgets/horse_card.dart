import 'package:flutter/material.dart';
import 'package:stable_vitals/core/constants/app_colors.dart';
import 'package:stable_vitals/models/horse.dart';
import 'status_badge.dart';

class HorseCard extends StatelessWidget {
  final Horse horse;
  final VoidCallback? onTap;

  const HorseCard({
    super.key,
    required this.horse,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _HorseAvatar(
                    name: horse.name,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          horse.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Stall ${horse.stall} • Aisle ${horse.aisle}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),
                      ],
                    ),
                  ),

                  StatusBadge(
                    status: horse.status,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      title: 'Today',
                      value:
                          '${horse.todayWater.toStringAsFixed(1)} gal',
                    ),
                  ),

                  Expanded(
                    child: _Metric(
                      title: 'Rolling 24h',
                      value:
                          '${horse.rolling24Hours.toStringAsFixed(1)} gal',
                    ),
                  ),

                  Expanded(
                    child: _Metric(
                      title: 'Usual',
                      value:
                          '${horse.usualMin.toStringAsFixed(1)}–${horse.usualMax.toStringAsFixed(1)}',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              const Divider(),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.water_drop_outlined,
                    size: 17,
                    color: AppColors.brandGold,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    'Latest water event',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),

                  const Spacer(),

                  const Text(
                    '7:42 PM',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.textMuted,
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

class _HorseAvatar extends StatelessWidget {
  final String name;

  const _HorseAvatar({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final firstLetter =
        name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          firstLetter,
          style: const TextStyle(
            color: AppColors.brandGoldDark,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String title;
  final String value;

  const _Metric({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}