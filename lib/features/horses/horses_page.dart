import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:stable_vitals/models/horse.dart';

class HorsesPage extends StatefulWidget {
  const HorsesPage({super.key});

  @override
  State<HorsesPage> createState() => _HorsesPageState();
}

class _HorsesPageState extends State<HorsesPage> {
  // ===========================================================================
  // HORSE DATA
  // ===========================================================================

  final List<Horse> horses = const [
    Horse(
      id: '1',
      name: 'Toby',
      stall: '1',
      aisle: 'A',
      status: HorseStatus.urgent,
      todayWater: 3.0,
      rolling24Hours: 6.8,
      usualMin: 4.0,
      usualMax: 8.4,
    ),
    Horse(
      id: '2',
      name: 'Cory',
      stall: '2',
      aisle: 'A',
      status: HorseStatus.check,
      todayWater: 2.5,
      rolling24Hours: 5.8,
      usualMin: 4.0,
      usualMax: 6.8,
    ),
    Horse(
      id: '3',
      name: 'Gavin',
      stall: '3',
      aisle: 'A',
      status: HorseStatus.onTrack,
      todayWater: 7.1,
      rolling24Hours: 6.8,
      usualMin: 6.0,
      usualMax: 8.2,
    ),
    Horse(
      id: '4',
      name: 'Bo',
      stall: '4',
      aisle: 'A',
      status: HorseStatus.onTrack,
      todayWater: 12.4,
      rolling24Hours: 10.8,
      usualMin: 10.0,
      usualMax: 12.8,
    ),
    Horse(
      id: '5',
      name: 'Stuart',
      stall: '5',
      aisle: 'A',
      status: HorseStatus.onTrack,
      todayWater: 8.2,
      rolling24Hours: 7.2,
      usualMin: 7.0,
      usualMax: 8.8,
    ),
    Horse(
      id: '6',
      name: 'Dancer',
      stall: '6',
      aisle: 'A',
      status: HorseStatus.onTrack,
      todayWater: 9.0,
      rolling24Hours: 7.8,
      usualMin: 7.0,
      usualMax: 9.4,
    ),
    Horse(
      id: '7',
      name: 'Prince',
      stall: '7',
      aisle: 'A',
      status: HorseStatus.onTrack,
      todayWater: 8.7,
      rolling24Hours: 7.5,
      usualMin: 7.0,
      usualMax: 9.1,
    ),
    Horse(
      id: '8',
      name: 'Farrah',
      stall: '8',
      aisle: 'A',
      status: HorseStatus.onTrack,
      todayWater: 6.9,
      rolling24Hours: 6.3,
      usualMin: 6.0,
      usualMax: 7.9,
    ),
  ];

  // ===========================================================================
  // SEARCH
  // ===========================================================================

  String searchQuery = '';

  List<Horse> get filteredHorses {
    if (searchQuery.trim().isEmpty) {
      return horses;
    }

    final query = searchQuery.trim().toLowerCase();

    return horses.where((horse) {
      return horse.name.toLowerCase().contains(query) ||
          horse.stall.toLowerCase().contains(query);
    }).toList();
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
Widget build(BuildContext context) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),
      body: Column(
        children: [
          // =================================================================
          // HEADER
          // =================================================================

          Container(
            color: const Color(0xFF063C20),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: const _StableVitalsHeader(),
          ),

          // =================================================================
          // PAGE CONTENT
          // =================================================================

          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  // -----------------------------------------------------------
                  // TITLE
                  // -----------------------------------------------------------

                  const _DirectoryHeader(),

                  // -----------------------------------------------------------
                  // BARN / WEATHER / ONLINE
                  // -----------------------------------------------------------

                  const _BarnInformation(),

                  // -----------------------------------------------------------
                  // SEARCH
                  // -----------------------------------------------------------

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      11,
                      7,
                      11,
                      9,
                    ),
                    child: _SearchField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),

                  // -----------------------------------------------------------
                  // TABLE
                  // -----------------------------------------------------------

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: _HorseDirectoryTable(
                      horses: filteredHorses,
                      onHorseTap: (horse) {
                        _openHorseProfile(context, horse);
                      },
                    ),
                  ),

                  // -----------------------------------------------------------
                  // BOTTOM HELPER TEXT
                  // -----------------------------------------------------------

                  const SizedBox(height: 18),

                  const Center(
                    child: Text(
                      'Tap any horse to view full profile',
                      style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF77746C),
                        fontWeight: FontWeight.w500,
                      ),
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
  // ===========================================================================
  // HORSE PROFILE NAVIGATION
  // ===========================================================================

  void _openHorseProfile(
    BuildContext context,
    Horse horse,
  ) {
    context.push('/horses/${horse.id}');
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
// DIRECTORY HEADER
// =============================================================================

class _DirectoryHeader extends StatelessWidget {
  const _DirectoryHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        12,
        12,
        11,
        3,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Horses Directory',
          style: TextStyle(
            fontSize: 23,
            height: 1.1,
            fontWeight: FontWeight.w800,
            color: Color(0xFF173F27),
          ),
        ),
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
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        12,
        4,
        11,
        7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================================
          // BARN
          // ===================================================================

          Text(
            'Rancho Santa Fe Barn',
            style: TextStyle(
              fontSize: 9.5,
              height: 1.1,
              color: Color(0xFF55534D),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 5),

          // ===================================================================
          // DATE / TIME + WEATHER
          // ===================================================================

          Row(
            children: [
              Expanded(
                child: Text(
                  'TUE AUG 4 • 2:18 PM PDT • BARN LOCAL',
                  style: TextStyle(
                    fontSize: 8.2,
                    color: Color(0xFF64625B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(
                height: 27,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFC48A1B),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 9,
                    ),
                    child: Row(
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
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 5),

          // ===================================================================
          // COUNT / UPDATE / ONLINE
          // ===================================================================

          Row(
            children: [
              Text(
                '8 horses',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF64625B),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.circle,
                size: 5,
                color: Color(0xFF267441),
              ),
              SizedBox(width: 4),
              Text(
                'Updated 2:18 PM PDT',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF64625B),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.circle,
                size: 5,
                color: Color(0xFF267441),
              ),
              SizedBox(width: 4),
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF64625B),
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
// SEARCH FIELD
// =============================================================================

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF33332F),
        ),
        cursorColor: const Color(0xFF174C30),
        decoration: InputDecoration(
          hintText: 'Search horses',
          hintStyle: const TextStyle(
            fontSize: 10,
            color: Color(0xFF9A978F),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 19,
            color: Color(0xFF817E76),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 39,
            minHeight: 42,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 8,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Color(0xFFD8D6CF),
              width: .8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Color(0xFF174C30),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HORSE DIRECTORY TABLE
// =============================================================================

class _HorseDirectoryTable extends StatelessWidget {
  final List<Horse> horses;
  final ValueChanged<Horse> onHorseTap;

  const _HorseDirectoryTable({
    required this.horses,
    required this.onHorseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE0DED7),
            width: .8,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // ===================================================================
            // TABLE HEADER
            // ===================================================================
      
            const _TableHeader(),
      
            // ===================================================================
            // HORSE ROWS
            // ===================================================================
      
            if (horses.isEmpty)
              const SizedBox(
                height: 90,
                child: Center(
                  child: Text(
                    'No horses found',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF77746C),
                    ),
                  ),
                ),
              ),
      
            for (int index = 0; index < horses.length; index++)
              _HorseDirectoryRow(
                horse: horses[index],
                onTap: () {
                  onHorseTap(horses[index]);
                },
              ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TABLE HEADER
// =============================================================================

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFBFAF7),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          // ===================================================================
          // STALL
          // ===================================================================

          SizedBox(
            width: 54,
            child: Row(
              children: [
                const Text(
                  'STALL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF375344),
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.arrow_upward_rounded,
                  size: 10,
                  color: Color(0xFFBD8120),
                ),
              ],
            ),
          ),

          // ===================================================================
          // NAME
          // ===================================================================

          const Expanded(
            flex: 2,
            child: Text(
              'NAME',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF375344),
              ),
            ),
          ),

          // ===================================================================
          // STATUS
          // ===================================================================

          const Expanded(
            flex: 2,
            child: Text(
              'STATUS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF375344),
              ),
            ),
          ),

          // ===================================================================
          // INTAKE
          // ===================================================================

          const Expanded(
            flex: 2,
            child: Text(
              'INTAKE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF375344),
              ),
            ),
          ),

          const SizedBox(width: 21),
        ],
      ),
    );
  }
}

// =============================================================================
// HORSE DIRECTORY ROW
// =============================================================================

class _HorseDirectoryRow extends StatelessWidget {
  final Horse horse;
  final VoidCallback onTap;

  const _HorseDirectoryRow({
    required this.horse,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 57,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFE8E6E0),
                width: .7,
              ),
            ),
          ),
          child: Row(
            children: [
              // =================================================================
              // STALL
              // =================================================================

              SizedBox(
                width: 48,
                child: Text(
                  horse.stall,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: Color(0xFF47463F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // =================================================================
              // NAME
              // =================================================================

              Expanded(
                flex: 2,
                child: Text(
                  horse.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF282822),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // =================================================================
              // STATUS
              // =================================================================

              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _StatusBadge(
                    status: horse.status,
                  ),
                ),
              ),

              // =================================================================
              // INTAKE
              // =================================================================

              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '${horse.todayWater.toStringAsFixed(1)} / '
                    '${horse.rolling24Hours.toStringAsFixed(1)}–'
                    '${horse.usualMax.toStringAsFixed(1)} gal',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 8.2,
                      color: Color(0xFF55534D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // =================================================================
              // CHEVRON
              // =================================================================

              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 21,
                  color: Color(0xFF185033),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// STATUS BADGE
// =============================================================================

class _StatusBadge extends StatelessWidget {
  final HorseStatus status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    late final String text;
    late final Color background;

    switch (status) {
      case HorseStatus.urgent:
        text = 'URGENT';
        background = const Color(0xFF8F1118);
        break;

      case HorseStatus.check:
        text = 'CHECK';
        background = const Color(0xFFC2851A);
        break;

      case HorseStatus.onTrack:
        text = 'ON TRACK';
        background = const Color(0xFF0A4828);
        break;
    }

    return Container(
      height: 21,
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7,
          height: 1,
          fontWeight: FontWeight.w800,
          letterSpacing: .1,
        ),
      ),
    );
  }
}