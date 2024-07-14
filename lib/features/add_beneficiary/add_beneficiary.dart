import 'package:top_ups/core/injection/injection.dart';

import 'presentation/controllers/add_beneficiary_controller.dart';

void addBeneficiaryInjection() {
  _controllers();
}

void _controllers() {
  Injection().registerSingleton<AddBeneficiaryController>(
    AddBeneficiaryController(),
  );
}
