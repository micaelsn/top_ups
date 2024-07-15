abstract class TransitionEntity {
  String type;
  double value;
  DateTime date;
  String idBeneficiary;

  TransitionEntity({
    required this.type,
    required this.value,
    required this.date,
    required this.idBeneficiary,
  });
}
