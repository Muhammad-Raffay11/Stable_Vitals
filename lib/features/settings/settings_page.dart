import 'package:flutter/material.dart';
import 'package:stable_vitals/core/constants/app_colors.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsTile(
            icon: Icons.pets_outlined,
            title: 'Horse Management',
            subtitle: 'Manage horses and profiles',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Alert and notification preferences',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.tune_rounded,
            title: 'Baseline & Sensitivity',
            subtitle: 'Monitoring sensitivity settings',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.settings_input_antenna_outlined,
            title: 'Monitors',
            subtitle: 'Monitor connection and status',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.people_outline_rounded,
            title: 'Account & Permissions',
            subtitle: 'Users and access',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,

        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.brandGoldDark,
          ),
        ),

        title: Text(title),

        subtitle: Text(subtitle),

        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
      ),
    );
  }
}