import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:stable_vitals/models/horse.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  // ===========================================================================
  // HORSE DATA
  // ===========================================================================

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
          name: 'Dancer',
          stall: '6',
          aisle: 'A',
          status: HorseStatus.onTrack,
          todayWater: 9.1,
          rolling24Hours: 10.2,
          usualMin: 7.5,
          usualMax: 11.0,
          type: 'Thoroughbred',
          age: 6,
          workLevel: 'Moderate',
        ),
        Horse(
          id: '5',
          name: 'Prince',
          stall: '7',
          aisle: 'A',
          status: HorseStatus.onTrack,
          todayWater: 8.7,
          rolling24Hours: 9.8,
          usualMin: 7.0,
          usualMax: 10.5,
          type: 'Arabian',
          age: 8,
          workLevel: 'Moderate',
        ),
      ];

  // ===========================================================================
  // PAGE
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F2),

        body: Column(
          children: [
            Container(
              color: const Color(0xFF063C20),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: const _StableVitalsHeader(),
            ),

            Expanded(
              child: SafeArea(
                top: false,
                bottom: false,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    const _TopAlertBar(),

                    const _BarnInformation(),

                    const _AllHorsesHeader(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          for (final horse in horses)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _HorseCard(
                                horse: horse,
                                onTap: () {
                                  context.push(
                                    '/horses/${horse.id}',
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
// TOP ALERT BAR
// =============================================================================

class _TopAlertBar extends StatelessWidget {
  const _TopAlertBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        9,
        10,
        0,
      ),
      child: Row(
        children: [
          // ===================================================================
          // URGENT
          // ===================================================================

          Expanded(
            child: Container(
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFF970D16),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    size: 19,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      '1 URGENT • TOBY',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 4),

          // ===================================================================
          // CHECK
          // ===================================================================

          Expanded(
            child: Container(
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFFC48A1B),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 19,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      '1 CHECK • CODY',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 4),

          // ===================================================================
          // VIEW ALERTS
          // ===================================================================

          SizedBox(
            height: 37,
            width: 118,
            child: OutlinedButton(
              onPressed: () {
                context.go('/alerts');
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Color(0xFFDAD8D0),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tap to view alerts',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF4B4A45),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: Color(0xFF55534D),
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
// BARN INFORMATION
// =============================================================================

class _BarnInformation extends StatelessWidget {
  const _BarnInformation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================================
          // DATE + WEATHER
          // ===================================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'TUE AUG 4 • 2:18 PM PDT • BARN LOCAL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5C5A53),
                  ),
                ),
              ),

              // Weather
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC48A1B),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_sunny_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '102°F • AQI 148',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 1),

          // ===================================================================
          // ONLINE INFORMATION
          // ===================================================================

          const Row(
            children: [
              Text(
                'Updated 2:18 PM PDT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C5A53),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.circle,
                size: 6,
                color: Color(0xFF217341),
              ),
              SizedBox(width: 4),
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C5A53),
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
// ALL HORSES HEADER
// =============================================================================

class _AllHorsesHeader extends StatelessWidget {
  const _AllHorsesHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        11,
        7,
        11,
        8,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              'ALL HORSES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C482A),
                letterSpacing: .35,
              ),
            ),
            Divider(color: Colors.black,)
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HORSE CARD
// =============================================================================

class _HorseCard extends StatelessWidget {
  final Horse horse;
  final VoidCallback onTap;

  const _HorseCard({
    required this.horse,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 126,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE1DFD8),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(
            12,
            10,
            10,
            10,
          ),
          child: Row(
            children: [
              // =================================================================
              // STATUS CIRCLE
              // =================================================================

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF073F23),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // =================================================================
              // HORSE INFORMATION
              // =================================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // -----------------------------------------------------------
                    // NAME
                    // -----------------------------------------------------------

                    Text(
                      horse.name,
                      style: const TextStyle(
                        fontSize: 16.5,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF201F1B),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // -----------------------------------------------------------
                    // STALL
                    // -----------------------------------------------------------

                    Text(
                      'Stall ${horse.stall}',
                      style: const TextStyle(
                        fontSize: 10.5,
                        height: 1,
                        color: Color(0xFF5C5A53),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // -----------------------------------------------------------
                    // STATUS BADGE
                    // -----------------------------------------------------------

                    Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A4A2A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'ON TRACK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                          height: 2.15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    // -----------------------------------------------------------
                    // WATER
                    // -----------------------------------------------------------

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop_rounded,
                          size: 14,
                          color: Color(0xFF3E5047),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${horse.todayWater.toStringAsFixed(1)} gal today',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A4943),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // -----------------------------------------------------------
                    // LAST DRINK
                    // -----------------------------------------------------------

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 14,
                          color: Color(0xFF3E5047),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _lastDrinkTime(horse.name),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A4943),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // =================================================================
              // CHEVRON
              // =================================================================

              const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                  color: Color(0xFF174B31),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _lastDrinkTime(String name) {
    switch (name) {
      case 'Gavin':
        return 'Last drink 10:31 AM PDT';

      case 'Bo':
        return 'Last drink 10:36 AM PDT';

      case 'Stuart':
        return 'Last drink 1:47 PM PDT';

      case 'Dancer':
        return 'Last drink 1:58 PM PDT';

      case 'Prince':
        return 'Last drink 2:04 PM PDT';

      default:
        return 'Last drink 2:10 PM PDT';
    }
  }
}