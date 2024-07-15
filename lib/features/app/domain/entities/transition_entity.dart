abstract class TransitionEntity {
  String type;
  double value;
  DateTime date;

  TransitionEntity({
    required this.type,
    required this.value,
    required this.date,
  });
}
