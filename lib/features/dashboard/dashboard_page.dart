import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stable_vitals/models/alert.dart';
import 'package:stable_vitals/models/horse.dart';

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
        .where(
          (horse) => horse.status == HorseStatus.onTrack,
        )
        .take(3)
        .toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F2),

        body: Column(
          children: [
            // -----------------------------------------------------------------
            // HEADER (extends up through the status bar)
            // -----------------------------------------------------------------

            Container(
              color: const Color(0xFF063C20),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: const _StableVitalsHeader(),
            ),

            // -----------------------------------------------------------------
            // DASHBOARD CONTENT
            // -----------------------------------------------------------------

            Expanded(
              child: SafeArea(
                top: false,
                bottom: false,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _DashboardTopSection(),

                      const SizedBox(height: 8),

                      // -------------------------------------------------------
                      // ALERT CARDS
                      // -------------------------------------------------------

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _CompactAlertCard(
                                horse: urgentHorse,
                                severity: AlertSeverity.urgent,
                                title: 'URGENT',
                                metrics: [
                                  _MetricLine(
                                    icon: Icons.water_drop_rounded,
                                    primary:
                                        '${urgentHorse.todayWater.toStringAsFixed(1)} gal today',
                                    secondary:
                                        'Usual by now ${urgentHorse.usualMin.toStringAsFixed(1)}–${urgentHorse.usualMax.toStringAsFixed(1)}',
                                  ),
                                  const _MetricLine(
                                    icon: Icons.water_drop_rounded,
                                    primary: '8.9 gal last 24 hr',
                                    secondary: 'Usual 11–15',
                                  ),
                                  const _MetricLine(
                                    icon: Icons.access_time_rounded,
                                    primary: 'No drink for 9 hr 48 min',
                                    secondary: 'Last drink 4:30 AM PDT',
                                  ),
                                ],
                                onViewDetails: () {
                                  context.push(
                                    '/horses/${urgentHorse.id}',
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: _CompactAlertCard(
                                horse: checkHorse,
                                severity: AlertSeverity.check,
                                title: 'CHECK',
                                metrics: [
                                  _MetricLine(
                                    icon: Icons.water_drop_rounded,
                                    primary:
                                        '${checkHorse.todayWater.toStringAsFixed(1)} gal today',
                                    secondary:
                                        'Usual by now ${checkHorse.usualMin.toStringAsFixed(1)}–${checkHorse.usualMax.toStringAsFixed(1)}',
                                  ),
                                  const _MetricLine(
                                    icon: Icons.water_drop_rounded,
                                    primary: 'Usual daily range',
                                    secondary: '9–11 gal',
                                  ),
                                  const _MetricLine(
                                    icon: Icons.access_time_rounded,
                                    primary: 'Last drink 9:05 AM PDT',
                                  ),
                                ],
                                onViewDetails: () {
                                  context.push(
                                    '/horses/${checkHorse.id}',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // -------------------------------------------------------
                      // ALERT VISIBILITY NOTE
                      // -------------------------------------------------------

                      const Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 12,
                          right: 12,
                          bottom: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Urgent and Check remain visible',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF77756E),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.circle,
                              size: 4,
                              color: Color(0xFF99968C),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'On Track horses scroll',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF77756E),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // -------------------------------------------------------
                      // ALL HORSES
                      // -------------------------------------------------------

                      const Padding(
                        padding: EdgeInsets.fromLTRB(
                          12,
                          12,
                          12,
                          8,
                        ),
                        child: Text(
                          'ALL HORSES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .35,
                            color: Color(0xFF0D492A),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFE2E0D8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: .035,
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < normalHorses.length;
                                  i++) ...[
                                _HorseListRow(
                                  horse: normalHorses[i],
                                  lastWaterText: _lastWaterText(i),
                                  onTap: () {
                                    context.push(
                                      '/horses/${normalHorses[i].id}',
                                    );
                                  },
                                ),
                                if (i != normalHorses.length - 1)
                                  const Divider(
                                    height: 1,
                                    thickness: .7,
                                    indent: 56,
                                    endIndent: 10,
                                    color: Color(0xFFE8E6DE),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
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
// DASHBOARD TOP INFORMATION
// =============================================================================

class _DashboardTopSection extends StatelessWidget {
  const _DashboardTopSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        16,
        12,
        6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------------
          // TITLE
          // -------------------------------------------------------------------

          const Text(
            'Barn Dashboard',
            style: TextStyle(
              fontSize: 26,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF173D27),
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Rancho Santa Fe Barn',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF65645E),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          // -------------------------------------------------------------------
          // DATE + WEATHER
          // -------------------------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'TUE, AUG 4 • 2:18 PM • BARN LOCAL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF76736B),
                  ),
                ),
              ),

              const SizedBox(width: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC08A27),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_sunny_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '102°F • HIGH 104° / LOW 74° • AQI 148\n HEAT WARNING • UNHEALTHY AIR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // -------------------------------------------------------------------
          // BARN INFORMATION
          // -------------------------------------------------------------------

          const Row(
            children: [
              SizedBox(width: 1),

              Text(
                '8 horses  •',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF55534D),
                ),
              ),

              SizedBox(width: 6),

              Text(
                'Updated 2:18 PM PDT',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF55534D),
                ),
              ),

              SizedBox(width: 9),

              Icon(
                Icons.circle,
                size: 5,
                color: Color(0xFF237041),
              ),

              SizedBox(width: 4),

              Text(
                'Online',
                style: TextStyle(
                  fontSize: 10,
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

class _MetricLine {
  final IconData icon;
  final String primary;
  final String? secondary;

  const _MetricLine({
    required this.icon,
    required this.primary,
    this.secondary,
  });
}

class _CompactAlertCard extends StatelessWidget {
  final Horse horse;
  final AlertSeverity severity;
  final String title;
  final List<_MetricLine> metrics;
  final VoidCallback onViewDetails;

  const _CompactAlertCard({
    required this.horse,
    required this.severity,
    required this.title,
    required this.metrics,
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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE0DED6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: .04,
            ),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // -------------------------------------------------------------------
          // ALERT HEADER
          // -------------------------------------------------------------------

          Container(
            width: double.infinity,
            height: 38,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            color: headerColor,
            child: Row(
              children: [
                Icon(
                  isUrgent
                      ? Icons.warning_rounded
                      : Icons.check_circle_rounded,
                  size: 19,
                  color: Colors.white,
                ),

                const SizedBox(width: 7),

                Expanded(
                  child: Text(
                    '$title — ${horse.name} • Stall ${horse.stall}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------------------------------------------------
          // ALERT CONTENT
          // -------------------------------------------------------------------

          Padding(
            padding: const EdgeInsets.fromLTRB(
              8,
              8,
              8,
              8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < metrics.length; i++) ...[
                  _MetricLineWidget(metric: metrics[i]),
                  if (i != metrics.length - 1)
                    const SizedBox(height: 10),
                ],

                const SizedBox(height: 13),

                // ----------------------------------------------------------------
                // VIEW DETAILS BUTTON
                // ----------------------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: onViewDetails,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      backgroundColor: headerColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'View details',
                      style: TextStyle(
                        fontSize: 11,
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
// METRIC LINE
// =============================================================================

class _MetricLineWidget extends StatelessWidget {
  final _MetricLine metric;

  const _MetricLineWidget({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          metric.icon,
          size: 15,
          color: const Color(0xFF17482E),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric.primary,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF272722),
                ),
              ),
              if (metric.secondary != null) ...[
                const SizedBox(height: 1),
                Text(
                  metric.secondary!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B6A63),
                  ),
                ),
              ],
            ],
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
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ---------------------------------------------------------------
            // STATUS ICON
            // ---------------------------------------------------------------

            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF064528),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(width: 10),

            // ---------------------------------------------------------------
            // NAME
            // ---------------------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -----------------------------------------------------
                  // HORSE NAME + STALL
                  // -----------------------------------------------------

                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          horse.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF272722),
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      Flexible(
                        child: Text(
                          '• Stall ${horse.stall}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF69675F),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // -----------------------------------------------------
                  // TODAY • USUAL PATTERN • LAST DRINK
                  // -----------------------------------------------------

                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop_outlined,
                        size: 13,
                        color: Color(0xFF3D5146),
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          '${horse.todayWater.toStringAsFixed(1)} gal today',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF57554F),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Icon(
                        Icons.show_chart_rounded,
                        size: 13,
                        color: Color(0xFF3D5146),
                      ),
                      const SizedBox(width: 3),
                      const Flexible(
                        child: Text(
                          'Within usual pattern',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF57554F),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: Color(0xFF3D5146),
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          lastWaterText,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF57554F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 4),

            // ---------------------------------------------------------------
            // ARROW
            // ---------------------------------------------------------------

            const Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: Color(0xFF164C31),
            ),
          ],
        ),
      ),
    );
  }
}