// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:stable_vitals/core/widgets/app_bottom_navigation.dart';

import 'package:stable_vitals/features/alerts/alerts_page.dart';
import 'package:stable_vitals/features/dashboard/dashboard_page.dart';
import 'package:stable_vitals/features/horses/horse_profile_page.dart';
import 'package:stable_vitals/features/horses/horses_page.dart';
import 'package:stable_vitals/features/settings/settings_page.dart';

import 'package:stable_vitals/models/horse.dart';


// =============================================================================
// HORSE DATA
// =============================================================================

final List<Horse> horses = const [

  Horse(
    id: '1',
    name: 'Toby',
    stall: '1',
    aisle: 'A',
    status: HorseStatus.check,
    todayWater: 3.0,
    rolling24Hours: 7.9,
    usualMin: 4.8,
    usualMax: 6.2,
  ),

  Horse(
    id: '2',
    name: 'Cory',
    stall: '2',
    aisle: 'A',
    status: HorseStatus.check,
    todayWater: 2.5,
    rolling24Hours: 5.8,
    usualMin: 5.8,
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
    usualMin: 6.8,
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
    usualMin: 10.8,
    usualMax: 12.8,
  ),

  Horse(
    id: '5',
    name: 'Stuart',
    stall: '5',
    aisle: 'A',
    status: HorseStatus.onTrack,
    todayWater: 8.2,
    rolling24Hours: 8.8,
    usualMin: 7.8,
    usualMax: 8.8,
  ),

  Horse(
    id: '6',
    name: 'Dancer',
    stall: '6',
    aisle: 'A',
    status: HorseStatus.onTrack,
    todayWater: 9.0,
    rolling24Hours: 7.9,
    usualMin: 7.9,
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
    usualMin: 7.5,
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
    usualMin: 6.3,
    usualMax: 7.9,
  ),
];


// =============================================================================
// APP ROUTER
// =============================================================================

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  routes: [

    // =========================================================================
    // SHELL ROUTE
    // =========================================================================

    ShellRoute(
      builder: (
        BuildContext context,
        GoRouterState state,
        Widget child,
      ) {
        int currentIndex = 0;

        // ---------------------------------------------------------------
        // DETERMINE SELECTED BOTTOM NAVIGATION ITEM
        // ---------------------------------------------------------------

        final path = state.uri.path;

        if (path == '/') {
          currentIndex = 0;
        } else if (path == '/alerts') {
          currentIndex = 1;
        } else if (
          path == '/horses' ||
          path.startsWith('/horses/')
        ) {
          currentIndex = 2;
        } else if (path == '/more') {
          currentIndex = 3;
        }

        return Scaffold(
          body: child,

          bottomNavigationBar: AppBottomNavigation(
            currentIndex: currentIndex,

            onDestinationSelected: (index) {
              switch (index) {

                case 0:
                  context.go('/');
                  break;

                case 1:
                  context.go('/alerts');
                  break;

                case 2:
                  context.go('/horses');
                  break;

                case 3:
                  context.go('/more');
                  break;
              }
            },
          ),
       
        );
      },

      routes: [

        // =====================================================================
        // DASHBOARD
        // =====================================================================

        GoRoute(
          path: '/',
          builder: (_, __) {
            return const DashboardPage();
          },
        ),

        // =====================================================================
        // HORSES DIRECTORY
        // =====================================================================

        GoRoute(
          path: '/horses',
          builder: (_, __) {
            return const HorsesPage();
          },
        ),

        // =====================================================================
        // HORSE PROFILE
        // =====================================================================

        GoRoute(
          path: '/horses/:id',

          builder: (
            BuildContext context,
            GoRouterState state,
          ) {
            // -------------------------------------------------------------
            // GET HORSE ID FROM URL
            // -------------------------------------------------------------

            final id = state.pathParameters['id'];

            // -------------------------------------------------------------
            // FIND HORSE
            // -------------------------------------------------------------

            Horse? selectedHorse;

            for (final horse in horses) {
              if (horse.id == id) {
                selectedHorse = horse;
                break;
              }
            }

            // -------------------------------------------------------------
            // HANDLE INVALID HORSE ID
            // -------------------------------------------------------------

            if (selectedHorse == null) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'Horse not found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }

            // -------------------------------------------------------------
            // OPEN HORSE PROFILE
            // -------------------------------------------------------------

            return HorseProfilePage(
              horse: selectedHorse,
            );
          },
        ),

        // =====================================================================
        // ALERTS
        // =====================================================================

        GoRoute(
          path: '/alerts',
          builder: (_, __) {
            return const AlertsPage();
          },
        ),

        // =====================================================================
        // SETTINGS
        // =====================================================================

        GoRoute(
          path: '/more',
          builder: (_, __) {
            return const SettingsPage();
          },
        ),
      ],
    ),
  ],
);