import 'package:top_ups/core/errors/failure.dart';

import '../../domain/types/signatures.dart';
import '../data_source/get_beneficiaries_data_source.dart';
import '../dto/beneficiary_dto.dart';

abstract class GetBeneficiariesRepository {
  Future<BeneficiaryResult> call();
}

class ApiGetBeneficiariesRepository implements GetBeneficiariesRepository {
  GetBeneficiariesDataSource dataSource;
  ApiGetBeneficiariesRepository({
    required this.dataSource,
  });
  @override
  Future<BeneficiaryResult> call() async {
    try {
      final response = await dataSource();
      final result = (response?['list'] as List)
          .map((item) => BeneficiaryDTO.fromMap(item))
          .toList();
      return BeneficiaryResult.right(result);
    } catch (error) {
      return BeneficiaryResult.left(
        const ServerFailure(),
      );
    }
  }
}
