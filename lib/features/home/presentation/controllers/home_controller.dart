import 'package:top_ups/features/home/domain/entities/beneficiary_entity.dart';

import '../../../../core/database/localstorage.dart';

class HomeController {
  final LocalStorage localStorage;

  HomeController({required this.localStorage});

  late List<BeneficiaryEntity> beneficiaries;

  Future<void> init() async {}
}
