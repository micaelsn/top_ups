import 'dart:convert';

import '../../domain/entities/beneficiary_entity.dart';

class BeneficiaryDTO extends BeneficiaryEntity {
  BeneficiaryDTO({
    required super.id,
    required super.name,
    required super.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  factory BeneficiaryDTO.fromMap(Map<String, dynamic> map) {
    return BeneficiaryDTO(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficiaryDTO.fromJson(String source) =>
      BeneficiaryDTO.fromMap(json.decode(source));
}
