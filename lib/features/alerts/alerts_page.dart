import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                            padding: const EdgeInsets.only(bottom: 7),
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

          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: const Text(
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
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFFD7AF4B),
                size: 25,
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
        8,
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
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF970D16),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    size: 17,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      '1 URGENT • TOBY',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 6),

          // ===================================================================
          // CHECK
          // ===================================================================

          Expanded(
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFC48A1B),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 17,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      '1 CHECK • CODY',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 6),

          // ===================================================================
          // VIEW ALERTS
          // ===================================================================

          SizedBox(
            height: 32,
            width: 105,
            child: OutlinedButton(
              onPressed: () {
                context.go('/alerts');
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Color(0xFFDAD8D0),
                  width: .9,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tap to view alerts',
                    style: TextStyle(
                      fontSize: 8.2,
                      color: Color(0xFF4B4A45),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
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
        11,
        10,
        11,
        7,
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
                  'TUE, AUG 2 • 2:18 PM • BARN LOCAL',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF67655E),
                  ),
                ),
              ),

              // Weather
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC48A1B),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      color: Colors.white,
                      size: 13,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '102°F • AQI 148',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // ===================================================================
          // ONLINE INFORMATION
          // ===================================================================

          const Row(
            children: [
              Text(
                'Updated 2:18 PM PDT',
                style: TextStyle(
                  fontSize: 8.5,
                  color: Color(0xFF69675F),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.circle,
                size: 5,
                color: Color(0xFF217341),
              ),
              SizedBox(width: 4),
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 8.5,
                  color: Color(0xFF69675F),
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
        6,
        11,
        7,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'ALL HORSES',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0C482A),
            letterSpacing: .3,
          ),
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
        borderRadius: BorderRadius.circular(9),
        child: Container(
          height: 112,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: const Color(0xFFE1DFD8),
              width: .9,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(
            11,
            9,
            9,
            9,
          ),
          child: Row(
            children: [
              // =================================================================
              // STATUS CIRCLE
              // =================================================================

              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFF073F23),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),

              const SizedBox(width: 11),

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
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF252520),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // -----------------------------------------------------------
                    // STALL
                    // -----------------------------------------------------------

                    Text(
                      'Stall ${horse.stall} • Aisle ${horse.aisle}',
                      style: const TextStyle(
                        fontSize: 9,
                        height: 1,
                        color: Color(0xFF65635D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // -----------------------------------------------------------
                    // STATUS BADGE
                    // -----------------------------------------------------------

                    Container(
                      height: 17,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A4A2A),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'ON TRACK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7.5,
                          height: 1.9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // -----------------------------------------------------------
                    // WATER
                    // -----------------------------------------------------------

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop_outlined,
                          size: 12,
                          color: Color(0xFF3E5047),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${horse.todayWater.toStringAsFixed(1)} gal today',
                          style: const TextStyle(
                            fontSize: 8.5,
                            color: Color(0xFF55534D),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    // -----------------------------------------------------------
                    // LAST DRINK
                    // -----------------------------------------------------------

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: Color(0xFF3E5047),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _lastDrinkTime(horse.name),
                          style: const TextStyle(
                            fontSize: 8.5,
                            color: Color(0xFF55534D),
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
                  size: 28,
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