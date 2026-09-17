import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

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
                icon: TablerIcons.home,
                selectedIcon: TablerIcons.home,
                label: 'Barn',
                onTap: onDestinationSelected,
              ),
              _NavItem(
                index: 1,
                currentIndex: currentIndex,
                icon: TablerIcons.bell,
                selectedIcon: TablerIcons.bell,
                label: 'Alerts',
                onTap: onDestinationSelected,
              ),
              _NavItem(
                index: 2,
                currentIndex: currentIndex,
                icon: TablerIcons.horse_toy,
                // No filled variant exists for "horse" in Tabler,
                // so the same glyph is reused for the selected state.
                selectedIcon: TablerIcons.horse_toy,
                label: 'Horses',
                onTap: onDestinationSelected,
              ),
              _NavItem(
                index: 3,
                currentIndex: currentIndex,
                icon: TablerIcons.settings,
                selectedIcon: TablerIcons.settings_filled,
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

  final IconData icon;
  final IconData selectedIcon;
  final String label;

  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = index == currentIndex;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              size: selected ? 21 : 19,
              color: selected
                  ? const Color(0xFFD4A83E)
                  : const Color(0xFFB8BDB5),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 7.5,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: selected
                    ? const Color(0xFFD4A83E)
                    : const Color(0xFFB8BDB5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}