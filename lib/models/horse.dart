enum HorseStatus {
  urgent,
  check,
  onTrack,
}

class Horse {
  final String id;
  final String name;
  final String stall;
  final String aisle;

  final HorseStatus status;

  final double todayWater;
  final double rolling24Hours;

  final double usualMin;
  final double usualMax;

  final String? type;
  final int? age;
  final String? workLevel;

  const Horse({
    required this.id,
    required this.name,
    required this.stall,
    required this.aisle,
    required this.status,
    required this.todayWater,
    required this.rolling24Hours,
    required this.usualMin,
    required this.usualMax,
    this.type,
    this.age,
    this.workLevel,
  });
}