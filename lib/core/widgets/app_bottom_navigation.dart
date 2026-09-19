import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF063C20),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 55,
          child: Row(
            children: [
              _NavItem(
                index: 0,
                currentIndex: currentIndex,
                assetPath: 'assets/icons/stable_vitals_nav_barn.svg',
                label: 'Barn',
                onTap: onDestinationSelected,
              ),
              _NavItem(
                index: 1,
                currentIndex: currentIndex,
                assetPath: 'assets/icons/stable_vitals_nav_bell.svg',
                label: 'Alerts',
                onTap: onDestinationSelected,
              ),
              _NavItem(
                index: 2,
                currentIndex: currentIndex,
                assetPath: 'assets/icons/stable_vitals_nav_horse.svg',
                label: 'Horses',
                onTap: onDestinationSelected,
              ),
              _NavItem(
                index: 3,
                currentIndex: currentIndex,
                assetPath: 'assets/icons/stable_vitals_nav_settings.svg',
                label: 'Settings',
                onTap: onDestinationSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;

  final String assetPath;
  final String label;

  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = index == currentIndex;

    final color = selected
        ? const Color(0xFFD4A83E)
        : const Color(0xFFB8BDB5);

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetPath,
              width: selected ? 21 : 19,
              height: selected ? 21 : 19,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 7.5,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}