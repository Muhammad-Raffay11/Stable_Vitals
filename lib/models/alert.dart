import 'horse.dart';

enum AlertState {
  active,
  acknowledged,
  resolved,
}

class HorseAlert {
  final String id;
  final Horse horse;

  final AlertSeverity severity;
  final AlertState state;

  final String message;
  final DateTime createdAt;

  const HorseAlert({
    required this.id,
    required this.horse,
    required this.severity,
    required this.state,
    required this.message,
    required this.createdAt,
  });
}

enum AlertSeverity {
  check,
  urgent,
}