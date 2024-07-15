import 'package:top_ups/core/returns/result_type.dart';
import 'package:top_ups/features/recharge_mobile/domain/entities/beneficiary_entity.dart';

typedef BeneficiaryResult = Result<List<BeneficiaryEntity>>;
typedef RechargeResult = Result<bool>;
