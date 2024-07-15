import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';
import 'package:top_ups/features/recharge_mobile/domain/entities/beneficiary_entity.dart';

import '../../domain/types/signatures.dart';

abstract class AddBeneficiariesRepository {
  Future<AddBeneficiaryResult> call(BeneficiaryEntity entity);
}

class ApiAddBeneficiariesRepository implements AddBeneficiariesRepository {
  final LocalStorage localStorage;
  ApiAddBeneficiariesRepository({
    required this.localStorage,
  });
  @override
  Future<AddBeneficiaryResult> call(BeneficiaryEntity entity) async {
    try {
      await localStorage.insert(
          'beneficiaries', (entity as BeneficiaryDTO).toMap());
      return AddBeneficiaryResult.right(true);
    } catch (error) {
      return AddBeneficiaryResult.left(
        const AddFailure(),
      );
    }
  }
}
