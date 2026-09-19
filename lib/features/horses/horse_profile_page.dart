// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:stable_vitals/models/horse.dart';

class HorseProfilePage extends StatelessWidget {
  final Horse horse;

  const HorseProfilePage({
    super.key,
    required this.horse,
  });

  // ===========================================================================
  // PROFILE DATA
  // ===========================================================================

  _HorseProfileData get profileData {
    if (horse.id == '1' && horse.name.toLowerCase() == 'toby') {
      return const _HorseProfileData(
        barn: 'Main Barn',
        aisle: 'North Aisle',
        updated: '10:42 AM',

        today: 2.0,
        todayTime: 'Since 12:00 AM',

        yesterday: 11.9,
        yesterdaySubtitle: 'Midnight–midnight',

        last24Hours: 7.9,
        last24Subtitle: 'Rolling total',

        sevenDayAverage: 13.0,

        usualByNowMin: 4.8,
        usualByNowMax: 6.2,

        usualFullDayMin: 11.0,
        usualFullDayMax: 15.0,

        lastDrink: '4:30 AM',

        alertTitle: 'CHECK',
        alertMessage: 'Meaningfully below usual by now',
        alertSeverity: 'check',
      );
    }

    // -------------------------------------------------------------------------
    // DEFAULT DATA FOR OTHER HORSES
    // -------------------------------------------------------------------------

    return _HorseProfileData(
      barn: 'Main Barn',
      aisle: horse.aisle == 'A' ? 'North Aisle' : 'South Aisle',
      updated: '10:42 AM',

      today: horse.todayWater,
      todayTime: 'Since 12:00 AM',

      // These fields will eventually come from your database/API.
      yesterday: horse.rolling24Hours,
      yesterdaySubtitle: 'Midnight–midnight',

      last24Hours: horse.rolling24Hours,
      last24Subtitle: 'Rolling total',

      sevenDayAverage: horse.rolling24Hours,

      usualByNowMin: horse.usualMin,
      usualByNowMax: horse.usualMax,

      usualFullDayMin: horse.usualMin,
      usualFullDayMax: horse.usualMax,

      lastDrink: '4:30 AM',

      alertTitle: _statusText(horse.status),
      alertMessage: _statusMessage(horse.status),
      alertSeverity: _statusText(horse.status).toLowerCase(),
    );
  }

  static String _statusText(HorseStatus status) {
    switch (status) {
      case HorseStatus.urgent:
        return 'URGENT';

      case HorseStatus.check:
        return 'CHECK';

      case HorseStatus.onTrack:
        return 'ON TRACK';
    }
  }

  static String _statusMessage(HorseStatus status) {
    switch (status) {
      case HorseStatus.urgent:
        return 'Significantly below usual by now';

      case HorseStatus.check:
        return 'Meaningfully below usual by now';

      case HorseStatus.onTrack:
        return 'Hydration is within the usual range';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = profileData;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F5F0),

        body: Column(
          children: [
            // =================================================================
            // STABLE VITALS HEADER
            // =================================================================

            Container(
              color: const Color(0xFF063C20),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: const _StableVitalsHeader(),
            ),

            // =================================================================
            // CONTENT
            // =================================================================

            Expanded(
              child: SafeArea(
                top: false,
                bottom: false,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    9,
                    5,
                    9,
                    18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------------------------------------------------------
                      // BACK TO HORSES
                      // ---------------------------------------------------------

                      _BackButton(
                        onTap: () {
                          context.pop();
                        },
                      ),

                      const SizedBox(height: 6),

                      // ---------------------------------------------------------
                      // HORSE HEADER
                      // ---------------------------------------------------------

                      _HorseHeader(
                        horse: horse,
                        data: data,
                      ),

                      const SizedBox(height: 8),

                      // ---------------------------------------------------------
                      // ALERT
                      // ---------------------------------------------------------

                      _HorseAlertCard(
                        horse: horse,
                        data: data,
                        onDetailsTap: () {
                          _showAlertDetails(
                            context,
                            data,
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      // ---------------------------------------------------------
                      // HYDRATION SNAPSHOT
                      // ---------------------------------------------------------

                      const _SectionTitle(
                        title: 'Hydration Snapshot',
                      ),

                      const SizedBox(height: 6),

                      _HydrationGrid(
                        data: data,
                      ),

                      const SizedBox(height: 8),

                      // ---------------------------------------------------------
                      // USUAL HYDRATION RANGE
                      // ---------------------------------------------------------

                      _UsualHydrationCard(
                        horse: horse,
                        data: data,
                      ),

                      const SizedBox(height: 10),

                      // ---------------------------------------------------------
                      // TODAY'S PATTERN
                      // ---------------------------------------------------------

                      const _SectionTitle(
                        title: "Today's Pattern",
                      ),

                      const SizedBox(height: 5),

                      _HydrationChart(
                        data: data,
                      ),

                      const SizedBox(height: 8),

                      // ---------------------------------------------------------
                      // HISTORY BUTTON
                      // ---------------------------------------------------------

                      SizedBox(
                        width: double.infinity,
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () {
                            _showHydrationHistory(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF064526),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'View Hydration History',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ---------------------------------------------------------
                      // ADD CONTEXT NOTE
                      // ---------------------------------------------------------

                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _showAddContextNote(context);
                          },
                          icon: const Icon(
                            Icons.note_add_outlined,
                            size: 15,
                          ),
                          label: const Text(
                            'Add Context Note',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                const Color(0xFF4E534C),
                            side: const BorderSide(
                              color: Color(0xFFBDBDB6),
                              width: .8,
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // ALERT DETAILS
  // ===========================================================================

  void _showAlertDetails(
    BuildContext context,
    _HorseProfileData data,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${horse.name} Alert',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF173F27),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                data.alertMessage,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF55534D),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 17,
                    color: Color(0xFF65655F),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Last drink ${data.lastDrink}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF55534D),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // HYDRATION HISTORY
  // ===========================================================================

  void _showHydrationHistory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Hydration history will be available here.',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ===========================================================================
  // CONTEXT NOTE
  // ===========================================================================

  void _showAddContextNote(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Add Context Note',
            style: const TextStyle(
              color: Color(0xFF173F27),
              fontWeight: FontWeight.w700,
            ),
          ),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText:
                  'Example: Horse was exercised this morning...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Context note added.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF064526),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

// =============================================================================
// PROFILE DATA MODEL
// =============================================================================

class _HorseProfileData {
  final String barn;
  final String aisle;
  final String updated;

  final double today;
  final String todayTime;

  final double yesterday;
  final String yesterdaySubtitle;

  final double last24Hours;
  final String last24Subtitle;

  final double sevenDayAverage;

  final double usualByNowMin;
  final double usualByNowMax;

  final double usualFullDayMin;
  final double usualFullDayMax;

  final String lastDrink;

  final String alertTitle;
  final String alertMessage;
  final String alertSeverity;

  const _HorseProfileData({
    required this.barn,
    required this.aisle,
    required this.updated,
    required this.today,
    required this.todayTime,
    required this.yesterday,
    required this.yesterdaySubtitle,
    required this.last24Hours,
    required this.last24Subtitle,
    required this.sevenDayAverage,
    required this.usualByNowMin,
    required this.usualByNowMax,
    required this.usualFullDayMin,
    required this.usualFullDayMax,
    required this.lastDrink,
    required this.alertTitle,
    required this.alertMessage,
    required this.alertSeverity,
  });
}

// =============================================================================
// HEADER
// =============================================================================

class _StableVitalsHeader extends StatelessWidget {
  const _StableVitalsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      color: const Color(0xFF063C20),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        children: [
          // -------------------------------------------------------------------
          // HORSE LOGO
          // -------------------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                'assets/images/stable_vitals_logo_wide_1024.png',
                fit: BoxFit.contain,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return const Icon(
                    Icons.pets_outlined,
                    color: Color(0xFFD3A83F),
                    size: 27,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),

          // -------------------------------------------------------------------
          // STABLE VITALS
          // -------------------------------------------------------------------

          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'STABLE VITALS',
              style: TextStyle(
                color: Color(0xFFD3A83F),
                fontSize: 24,
                fontFamily: 'serif',
                fontWeight: FontWeight.w500,
                letterSpacing: .3,
              ),
            ),
          ),

          const Spacer(),

          // -------------------------------------------------------------------
          // NOTIFICATION
          // -------------------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              onPressed: () {
                context.go('/alerts');
              },
              icon: SvgPicture.asset(
                'assets/icons/stable_vitals_nav_bell.svg',
                width: 25,
                height: 25,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFD7AF4B),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// BACK BUTTON
// =============================================================================

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 13,
              color: Color(0xFF4D514B),
            ),
            SizedBox(width: 4),
            Text(
              'Horses',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF353933),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HORSE HEADER
// =============================================================================

class _HorseHeader extends StatelessWidget {
  final Horse horse;
  final _HorseProfileData data;

  const _HorseHeader({
    required this.horse,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ---------------------------------------------------------------------
        // HORSE IMAGE
        // ---------------------------------------------------------------------

        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFB9B7B0),
              width: .8,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/images/horses/${horse.id}.jpg',
            fit: BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                color: const Color(0xFFD7D5CE),
                child: const Icon(
                  Icons.pets_rounded,
                  size: 30,
                  color: Color(0xFF496252),
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 9),

        // ---------------------------------------------------------------------
        // NAME + LOCATION
        // ---------------------------------------------------------------------

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                horse.name,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF173F27),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '${data.barn} • ${data.aisle} • Stall ${horse.stall}',
                style: const TextStyle(
                  fontSize: 9.2,
                  color: Color(0xFF343A34),
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                'Data updated ${data.updated}',
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF6C6C65),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// ALERT CARD
// =============================================================================

class _HorseAlertCard extends StatelessWidget {
  final Horse horse;
  final _HorseProfileData data;
  final VoidCallback onDetailsTap;

  const _HorseAlertCard({
    required this.horse,
    required this.data,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUrgent =
        horse.status == HorseStatus.urgent;

    final color = isUrgent
        ? const Color(0xFF9A5500)
        : const Color(0xFFA36A10);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F3),
        border: Border.all(
          color: const Color(0xFFC7A87B),
          width: .9,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              9,
              8,
              9,
              7,
            ),
            child: Row(
              children: [
                // -------------------------------------------------------------
                // WARNING ICON
                // -------------------------------------------------------------

                Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Icons.priority_high_rounded,
                    color: Colors.white,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 10),

                // -------------------------------------------------------------
                // STATUS
                // -------------------------------------------------------------

                Text(
                  data.alertTitle,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),

                const SizedBox(width: 11),

                Container(
                  height: 27,
                  width: 1,
                  color: const Color(0xFFD4CEC3),
                ),

                const SizedBox(width: 10),

                // -------------------------------------------------------------
                // MESSAGE
                // -------------------------------------------------------------

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.alertMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF6D5129),
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 12.5,
                            color: Color(0xFF696A63),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Last drink ${data.lastDrink}',
                            style: const TextStyle(
                              fontSize: 7.5,
                              color: Color(0xFF62635E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // -------------------------------------------------------------------
          // DETAILS BUTTON
          // -------------------------------------------------------------------

          InkWell(
            onTap: onDetailsTap,
            child: Container(
              height: 33,
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFDCD6CA),
                    width: .7,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Color(0xFF607068),
                  ),
                  SizedBox(width: 7),
                  Text(
                    'View alert details',
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF385345),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION TITLE
// =============================================================================

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12.5,
        height: 1,
        fontWeight: FontWeight.w900,
        color: Color(0xFF234D35),
      ),
    );
  }
}

// =============================================================================
// HYDRATION GRID
// =============================================================================

class _HydrationGrid extends StatelessWidget {
  final _HorseProfileData data;

  const _HydrationGrid({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: Icons.calendar_month_outlined,
                title: 'Today',
                value:
                    '${data.today.toStringAsFixed(1)} gal',
                subtitle: data.todayTime,
              ),
            ),

            const SizedBox(width: 7),

            Expanded(
              child: _MetricCard(
                icon: Icons.calendar_month_outlined,
                title: 'Yesterday',
                value:
                    '${data.yesterday.toStringAsFixed(1)} gal',
                subtitle: data.yesterdaySubtitle,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: Icons.access_time_rounded,
                title: 'Last 24 Hours',
                value:
                    '${data.last24Hours.toStringAsFixed(1)} gal',
                subtitle: data.last24Subtitle,
              ),
            ),

            const SizedBox(width: 7),

            Expanded(
              child: _MetricCard(
                icon: Icons.bar_chart_rounded,
                title: '7-Day Average',
                value:
                    '${data.sevenDayAverage.toStringAsFixed(1)} gal/day',
                subtitle: '',
                valueFontSize: 16.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// METRIC CARD
// =============================================================================

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final double valueFontSize;

  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    this.valueFontSize = 16.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        border: Border.all(
          color: const Color(0xFFE0DED8),
          width: .7,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
            color: const Color(0xFF385D4A),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF4B4C45),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 1),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: valueFontSize,
                    height: 1,
                    color: const Color(0xFF252A26),
                    fontWeight: FontWeight.w800,
                  ),
                ),

                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 6.8,
                      color: Color(0xFF6F7069),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// USUAL HYDRATION CARD
// =============================================================================

class _UsualHydrationCard extends StatelessWidget {
  final Horse horse;
  final _HorseProfileData data;

  const _UsualHydrationCard({
    required this.horse,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        9,
        6,
        9,
        4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F6),
        border: Border.all(
          color: const Color(0xFF83988C),
          width: .9,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF075034),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'USUAL BY 10:42 AM',
                        style: TextStyle(
                          fontSize: 7,
                          color: Color(0xFF52675B),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '${data.usualByNowMin.toStringAsFixed(1)}–'
                        '${data.usualByNowMax.toStringAsFixed(1)} gal',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1,
                          color: Color(0xFF27342D),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 37,
                  width: .8,
                  color: const Color(0xFFC8CDC8),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'USUAL FULL DAY',
                        style: TextStyle(
                          fontSize: 7,
                          color: Color(0xFF52675B),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '${data.usualFullDayMin.toStringAsFixed(0)}–'
                        '${data.usualFullDayMax.toStringAsFixed(0)} gal',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1,
                          color: Color(0xFF27342D),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Text(
            "Based on ${horse.name}'s individual drinking pattern",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 6.3,
              color: Color(0xFF62685F),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SMALL POSITIONED TEXT HELPER
// =============================================================================

class PositionedText extends StatelessWidget {
  final String text;

  const PositionedText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

// =============================================================================
// HYDRATION CHART
// =============================================================================

class _HydrationChart extends StatelessWidget {
  final _HorseProfileData data;

  const _HydrationChart({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        border: Border.all(
          color: const Color(0xFFE1DED6),
          width: .8,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          // -------------------------------------------------------------------
          // Y AXIS LABEL
          // -------------------------------------------------------------------

          const Positioned(
            left: 6,
            top: 8,
            child: Text(
              'Gallons',
              style: TextStyle(
                fontSize: 6.8,
                color: Color(0xFF585950),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // -------------------------------------------------------------------
          // CHART
          // -------------------------------------------------------------------

          Positioned(
            left: 25,
            right: 7,
            top: 28,
            bottom: 28,
            child: CustomPaint(
              painter: _HydrationChartPainter(
                status:
                    data.alertSeverity,
              ),
            ),
          ),

          // -------------------------------------------------------------------
          // LAST DRINK LABEL
          // -------------------------------------------------------------------

          Positioned(
            top: 7,
            left: 82,
            child: _LastDrinkLabel(
              text: 'Last drink ${data.lastDrink}',
            ),
          ),

          // -------------------------------------------------------------------
          // X AXIS
          // -------------------------------------------------------------------

          const Positioned(
            left: 24,
            right: 6,
            bottom: 8,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                _AxisLabel('12 AM'),
                _AxisLabel('2 AM'),
                _AxisLabel('4 AM'),
                _AxisLabel('6 AM'),
                _AxisLabel('8 AM'),
                _AxisLabel('10 AM'),
                _AxisLabel('10:42 AM\nNow'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// CHART PAINTER
// =============================================================================

class _HydrationChartPainter extends CustomPainter {
  final String status;

  _HydrationChartPainter({
    required this.status,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = const Color(0xFF305A47);

    // -------------------------------------------------------------------------
    // GRID
    // -------------------------------------------------------------------------

    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = const Color(0xFFE4E2DD);

    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // -------------------------------------------------------------------------
    // HYDRATION LINE
    // -------------------------------------------------------------------------

    final path = Path();

    path.moveTo(
      0,
      size.height * .86,
    );

    path.lineTo(
      size.width * .76,
      size.height * .43,
    );

    path.lineTo(
      size.width,
      size.height * .43,
    );

    canvas.drawPath(
      path,
      paint,
    );

    // -------------------------------------------------------------------------
    // MAIN POINT
    // -------------------------------------------------------------------------

    final pointPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF174E35);

    canvas.drawCircle(
      Offset(
        size.width * .34,
        size.height * .43,
      ),
      2.8,
      pointPaint,
    );

    // -------------------------------------------------------------------------
    // LAST POINT
    // -------------------------------------------------------------------------

    final lastPointPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = status == 'urgent'
          ? const Color(0xFF8E1417)
          : const Color(0xFF8E1417);

    canvas.drawCircle(
      Offset(
        size.width,
        size.height * .43,
      ),
      3,
      lastPointPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _HydrationChartPainter oldDelegate,
  ) {
    return oldDelegate.status != status;
  }
}

// =============================================================================
// LAST DRINK LABEL
// =============================================================================

class _LastDrinkLabel extends StatelessWidget {
  final String text;

  const _LastDrinkLabel({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3.5,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF7E1016),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 6.8,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// =============================================================================
// AXIS LABEL
// =============================================================================

class _AxisLabel extends StatelessWidget {
  final String text;

  const _AxisLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 6.2,
        height: 1.1,
        fontWeight: FontWeight.w500,
        color: Color(0xFF5C5D56),
      ),
    );
  }
}