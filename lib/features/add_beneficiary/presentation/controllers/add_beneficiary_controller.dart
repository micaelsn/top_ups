import 'dart:math';

import 'package:flutter/material.dart';
import 'package:top_ups/core/injection/injection.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';
import 'package:top_ups/features/recharge_mobile/presentation/controllers/recharge_mobile_controller.dart';

import '../../domain/usecases/add_beneficiaries_usecase.dart';
import 'add_beneficiary_state.dart';

class AddBeneficiaryController extends ValueNotifier<AddBeneficiaryState> {
  AddBeneficiaryController({required this.addUseCase})
      : super(AddBeneficiaryStateInitial());

  final AddBeneficiariesUsecase addUseCase;

  static const int maxNickNameLength = 20;
  static const int maxPhoneLength = 11;

  ValueNotifier<String?> nameError = ValueNotifier(null);
  ValueNotifier<String?> phoneError = ValueNotifier(null);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  static const String errorMessage = "This field is invalid.";

  sendValidate({String? name, String? phone}) {
    if (name != null) {
      nameError.value =
          name.isEmpty || name.length > maxNickNameLength ? errorMessage : null;
    }
    if (phone != null) {
      phoneError.value =
          phone.isEmpty || phone.length < maxPhoneLength ? errorMessage : null;
    }
  }

  Future<void> add() async {
    value = AddBeneficiaryStateLoading();
    sendValidate(
      name: nameController.text,
      phone: phoneController.text,
    );
    if (fieldsIsValid) {
      var random = Random();
      final result = await addUseCase(BeneficiaryDTO(
        id: random.nextInt(10000).toString(),
        name: nameController.text,
        phone: phoneController.text,
      ));
      return result.fold((l) {
        value = AddBeneficiaryStateError();
      }, (r) {
        Injection().get<RechargeMobileController>().init();
        value = AddBeneficiaryStateSuccess();
      });
    }
  }

  bool get fieldsIsValid => nameError.value == null && phoneError.value == null;
}
