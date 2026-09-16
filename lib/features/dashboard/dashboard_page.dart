import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/alert.dart';
import '../../models/horse.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // ---------------------------------------------------------------------------
  // DEMO HORSE DATA
  // ---------------------------------------------------------------------------

  List<Horse> get horses => const [
        Horse(
          id: '1',
          name: 'Gavin',
          stall: '3',
          aisle: 'A',
          status: HorseStatus.onTrack,
          todayWater: 7.1,
          rolling24Hours: 8.9,
          usualMin: 6.8,
          usualMax: 8.4,
          type: 'Thoroughbred',
          age: 8,
          workLevel: 'Moderate',
        ),
        Horse(
          id: '2',
          name: 'Bo',
          stall: '4',
          aisle: 'A',
          status: HorseStatus.onTrack,
          todayWater: 12.4,
          rolling24Hours: 14.1,
          usualMin: 10.0,
          usualMax: 13.8,
          type: 'Quarter Horse',
          age: 7,
          workLevel: 'Moderate',
        ),
        Horse(
          id: '3',
          name: 'Stuart',
          stall: '5',
          aisle: 'A',
          status: HorseStatus.onTrack,
          todayWater: 8.2,
          rolling24Hours: 9.4,
          usualMin: 7.0,
          usualMax: 10.0,
          type: 'Arabian',
          age: 9,
          workLevel: 'Moderate',
        ),
        Horse(
          id: '4',
          name: 'Toby',
          stall: '1',
          aisle: 'A',
          status: HorseStatus.urgent,
          todayWater: 3.0,
          rolling24Hours: 3.9,
          usualMin: 6.8,
          usualMax: 8.4,
        ),
        Horse(
          id: '5',
          name: 'Cody',
          stall: '2',
          aisle: 'A',
          status: HorseStatus.check,
          todayWater: 2.5,
          rolling24Hours: 3.2,
          usualMin: 5.8,
          usualMax: 6.8,
        ),
      ];

  // ---------------------------------------------------------------------------
  // ALERT DATA
  // ---------------------------------------------------------------------------

  List<HorseAlert> get alerts {
    return [
      HorseAlert(
        id: 'alert-1',
        horse: horses[3],
        severity: AlertSeverity.urgent,
        state: AlertState.active,
        message: 'Water use is below the usual range.',
        createdAt: DateTime.now().subtract(
          const Duration(hours: 4, minutes: 48),
        ),
      ),
      HorseAlert(
        id: 'alert-2',
        horse: horses[4],
        severity: AlertSeverity.check,
        state: AlertState.active,
        message: 'Water use is lower than usual.',
        createdAt: DateTime.now().subtract(
          const Duration(hours: 5),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final urgentHorse = horses.firstWhere(
      (horse) => horse.status == HorseStatus.urgent,
    );

    final checkHorse = horses.firstWhere(
      (horse) => horse.status == HorseStatus.check,
    );

    final normalHorses = horses
        .where((horse) => horse.status == HorseStatus.onTrack)
        .take(3)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),

      // -----------------------------------------------------------------------
      // HEADER
      // -----------------------------------------------------------------------

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _StableVitalsHeader(),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  const _DashboardTopSection(),

                  // -----------------------------------------------------------
                  // ALERT CARDS
                  // -----------------------------------------------------------

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      10,
                      5,
                      10,
                      0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _CompactAlertCard(
                            horse: urgentHorse,
                            severity: AlertSeverity.urgent,
                            title: 'URGENT',
                            subtitle: 'Water use is low',
                            onViewDetails: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _CompactAlertCard(
                            horse: checkHorse,
                            severity: AlertSeverity.check,
                            title: 'CHECK',
                            subtitle: 'Water use is low',
                            onViewDetails: () {},
                          ),
                        ),
                      ],
                    ),
                  ),

                  // -----------------------------------------------------------
                  // ALERT VISIBILITY NOTE
                  // -----------------------------------------------------------

                  const Padding(
                    padding: EdgeInsets.only(
                      top: 7,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Urgent and Check remain visible',
                          style: TextStyle(
                            fontSize: 7.5,
                            color: Color(0xFF77756E),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.circle,
                          size: 3,
                          color: Color(0xFF99968C),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'On Track horses scroll',
                          style: TextStyle(
                            fontSize: 7.5,
                            color: Color(0xFF77756E),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // -----------------------------------------------------------
                  // ALL HORSES
                  // -----------------------------------------------------------

                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      10,
                      9,
                      10,
                      5,
                    ),
                    child: Text(
                      'ALL HORSES',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .2,
                        color: Color(0xFF0D492A),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0xFFE2E0D8),
                        ),
                      ),
                      child: Column(
                        children: [
                          for (int i = 0;
                              i < normalHorses.length;
                              i++) ...[
                            _HorseListRow(
                              horse: normalHorses[i],
                              lastWaterText: _lastWaterText(i),
                              onTap: () {},
                            ),
                            if (i != normalHorses.length - 1)
                              const Divider(
                                height: 1,
                                thickness: .7,
                                indent: 43,
                                endIndent: 8,
                                color: Color(0xFFE8E6DE),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _lastWaterText(int index) {
    switch (index) {
      case 0:
        return 'Last drink 10:31 AM PST';
      case 1:
        return 'Last drink 10:36 AM PST';
      default:
        return 'Last drink 1:47 PM PST';
    }
  }
}

// =============================================================================
// HEADER
// =============================================================================

class _StableVitalsHeader extends StatelessWidget {
  const _StableVitalsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: const Color(0xFF063C20),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [

          // ===================================================================
          // HORSE LOGO
          // ===================================================================

          SizedBox(
            width: 42,
            height: 38,
            child: Image.asset(
              'assets/images/stable_vitals_header_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return const Icon(
                  Icons.pets_outlined,
                  color: Color(0xFFD3A83F),
                  size: 25,
                );
              },
            ),
          ),

            const Spacer(),


          // ===================================================================
          // STABLE VITALS TEXT
          // ===================================================================

           Text(
            'STABLE VITALS',
            style: TextStyle(
              color: Color(0xFFD3A83F),
              fontSize: 17,
              fontFamily: 'serif',
              fontWeight: FontWeight.w400,
              letterSpacing: .3,
            ),
          ),

          const Spacer(),

          // ===================================================================
          // NOTIFICATION
          // ===================================================================

          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 34,
              minHeight: 34,
            ),
            onPressed: () {
              context.go('/alerts');
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFFD7AF4B),
              size: 21,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// DASHBOARD TOP INFORMATION
// =============================================================================

class _DashboardTopSection extends StatelessWidget {
  const _DashboardTopSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        10,
        4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------------------------------------------------
          // TITLE
          // ---------------------------------------------------------------

          const Text(
            'Barn Dashboard',
            style: TextStyle(
              fontSize: 20,
              height: 1.05,
              fontWeight: FontWeight.w800,
              color: Color(0xFF173D27),
            ),
          ),

          const SizedBox(height: 2),

          const Text(
            'Ranch Santa Fe Barn',
            style: TextStyle(
              fontSize: 8.5,
              color: Color(0xFF65645E),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 3),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'TUE, AUG 2 • 2:18 PM • BARN LOCAL',
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF76736B),
                  ),
                ),
              ),

              // -----------------------------------------------------------
              // WEATHER / BARN STATUS
              // -----------------------------------------------------------

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC08A27),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      size: 10,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '73°F • HIGH 104° / LOW 74°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          const Row(
            children: [
              Icon(
                Icons.pets_outlined,
                size: 9,
                color: Color(0xFF4E4C46),
              ),
              SizedBox(width: 3),
              Text(
                '8 horses',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF55534D),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.access_time_rounded,
                size: 8,
                color: Color(0xFF4E4C46),
              ),
              SizedBox(width: 2),
              Text(
                'Updated 2:18 PM PDT',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF55534D),
                ),
              ),
              SizedBox(width: 7),
              Icon(
                Icons.circle,
                size: 4,
                color: Color(0xFF237041),
              ),
              SizedBox(width: 3),
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF55534D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// COMPACT ALERT CARD
// =============================================================================

class _CompactAlertCard extends StatelessWidget {
  final Horse horse;
  final AlertSeverity severity;
  final String title;
  final String subtitle;
  final VoidCallback onViewDetails;

  const _CompactAlertCard({
    required this.horse,
    required this.severity,
    required this.title,
    required this.subtitle,
    required this.onViewDetails,
  });

  bool get isUrgent => severity == AlertSeverity.urgent;

  Color get headerColor {
    return isUrgent
        ? const Color(0xFF970E17)
        : const Color(0xFFC58614);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFE0DED6),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // -----------------------------------------------------------------
          // ALERT HEADER
          // -----------------------------------------------------------------

          Container(
            width: double.infinity,
            height: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
            ),
            color: headerColor,
            child: Row(
              children: [
                Icon(
                  isUrgent
                      ? Icons.warning_rounded
                      : Icons.check_circle_rounded,
                  size: 13,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '$title — ${horse.name} • Stall ${horse.stall}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 7.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // ALERT CONTENT
          // -----------------------------------------------------------------

          Padding(
            padding: const EdgeInsets.fromLTRB(
              7,
              7,
              7,
              7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AlertMetricRow(
                  icon: Icons.water_drop_outlined,
                  title: 'Today',
                  value:
                      '${horse.todayWater.toStringAsFixed(1)} gal today',
                ),

                const SizedBox(height: 5),

                _AlertMetricRow(
                  icon: Icons.analytics_outlined,
                  title: 'Usual',
                  value:
                      '${horse.usualMin.toStringAsFixed(1)}–${horse.usualMax.toStringAsFixed(1)}',
                ),

                const SizedBox(height: 5),

                _AlertMetricRow(
                  icon: Icons.calendar_today_outlined,
                  title: '24h',
                  value:
                      '${horse.rolling24Hours.toStringAsFixed(1)} gal past 24h',
                ),

                const SizedBox(height: 5),

                _AlertMetricRow(
                  icon: Icons.access_time_rounded,
                  title: 'Last drink',
                  value: isUrgent
                      ? '9:48 min ago'
                      : '9:05 AM PDT',
                ),

                const SizedBox(height: 8),

                // -----------------------------------------------------------
                // VIEW DETAILS BUTTON
                // -----------------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 21,
                  child: ElevatedButton(
                    onPressed: onViewDetails,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      backgroundColor: headerColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: const Text(
                      'View details',
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
// ALERT METRIC ROW
// =============================================================================

class _AlertMetricRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _AlertMetricRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF294C39),
              width: .7,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 8,
            color: const Color(0xFF17482E),
          ),
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF45443F),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// HORSE LIST ROW
// =============================================================================

class _HorseListRow extends StatelessWidget {
  final Horse horse;
  final String lastWaterText;
  final VoidCallback onTap;

  const _HorseListRow({
    required this.horse,
    required this.lastWaterText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: Row(
            children: [
              // -------------------------------------------------------------
              // STATUS ICON
              // -------------------------------------------------------------

              Container(
                width: 23,
                height: 23,
                decoration: const BoxDecoration(
                  color: Color(0xFF064528),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),

              const SizedBox(width: 7),

              // -------------------------------------------------------------
              // HORSE NAME
              // -------------------------------------------------------------

              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        horse.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF272722),
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '• Stall ${horse.stall}',
                      style: const TextStyle(
                        fontSize: 6.8,
                        color: Color(0xFF69675F),
                      ),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // TODAY
              // -------------------------------------------------------------

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      size: 8,
                      color: Color(0xFF3D5146),
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        '${horse.todayWater.toStringAsFixed(1)} gal today',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 6.2,
                          color: Color(0xFF57554F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // USUAL PATTERN
              // -------------------------------------------------------------

              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    const Icon(
                      Icons.show_chart_rounded,
                      size: 8,
                      color: Color(0xFF3D5146),
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        'Within usual pattern',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 6.2,
                          color: Color(0xFF57554F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // LAST DRINK
              // -------------------------------------------------------------

              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 8,
                      color: Color(0xFF3D5146),
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        lastWaterText,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 6.1,
                          color: Color(0xFF57554F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 2),

              // -------------------------------------------------------------
              // ARROW
              // -------------------------------------------------------------

              const Icon(
                Icons.chevron_right_rounded,
                size: 17,
                color: Color(0xFF164C31),
              ),
            ],
          ),
        ),
      ),
    );
  }
}