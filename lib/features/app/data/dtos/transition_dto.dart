import 'dart:convert';

import '../../domain/entities/transition_entity.dart';

class TransitionDTO extends TransitionEntity {
  TransitionDTO({
    required super.type,
    required super.value,
    required super.date,
    required super.idBeneficiary,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
      'date': date.millisecondsSinceEpoch,
      'idBeneficiary': idBeneficiary,
    };
  }

  factory TransitionDTO.fromMap(Map<String, dynamic> map) {
    return TransitionDTO(
      type: map['type'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      idBeneficiary: map['idBeneficiary'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransitionDTO.fromJson(String source) =>
      TransitionDTO.fromMap(json.decode(source));
}
