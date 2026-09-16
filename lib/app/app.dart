import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class StableVitalsApp extends StatelessWidget {
  const StableVitalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stable Vitals',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      routerConfig: appRouter,
    );
  }
}