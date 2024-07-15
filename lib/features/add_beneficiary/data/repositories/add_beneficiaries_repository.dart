import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/core/helpers/rules.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';
import 'package:top_ups/features/recharge_mobile/domain/entities/beneficiary_entity.dart';

import '../../domain/types/signatures.dart';

abstract class AddBeneficiariesRepository {
  Future<AddBeneficiaryResult> call(BeneficiaryEntity entity);
}

class LocalStorageAddBeneficiariesRepository
    implements AddBeneficiariesRepository {
  final LocalStorage localStorage;
  LocalStorageAddBeneficiariesRepository({
    required this.localStorage,
  });
  @override
  Future<AddBeneficiaryResult> call(BeneficiaryEntity entity) async {
    try {
      final result = await localStorage.get('beneficiaries');
      if ((result as List?)?.length == userMaxLengthBeneficiaries) {
        return AddBeneficiaryResult.left(
          const AddFailure(),
        );
      }
      final list = result != null && result.isNotEmpty
          ? [(entity as BeneficiaryDTO).toMap(), ...result]
          : [(entity as BeneficiaryDTO).toMap()];
      await localStorage.insert('beneficiaries', list);
      return AddBeneficiaryResult.right(true);
    } catch (error) {
      return AddBeneficiaryResult.left(
        const AddFailure(),
      );
    }
  }
}
