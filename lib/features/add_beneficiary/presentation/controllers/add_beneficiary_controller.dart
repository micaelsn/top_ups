import 'package:flutter/material.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';

import '../../domain/usecases/add_beneficiaries_usecase.dart';
import 'add_beneficiary_state.dart';

class AddBeneficiaryController extends ValueNotifier<AddBeneficiaryState> {
  AddBeneficiaryController({required this.addUseCase})
      : super(AddBeneficiaryStateInitial());

  final AddBeneficiariesUsecase addUseCase;

  static const int maxNickNameLength = 20;
  static const int maxPhoneLength = 11;
  // ValueNotifier<bool> isSending = ValueNotifier(false);

  ValueNotifier<String?> nameError = ValueNotifier(null);
  ValueNotifier<String?> phoneError = ValueNotifier(null);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  static const String errorMessage = "This field is required.";

  sendValidate({String? name, String? phone}) {
    if (name != null) {
      nameError.value =
          name.isEmpty && name.length < maxNickNameLength ? errorMessage : null;
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
      final result = await addUseCase(BeneficiaryDTO(
        id: '0',
        name: nameController.text,
        phone: phoneController.text,
      ));
      return result.fold((l) {
        value = AddBeneficiaryStateError();
      }, (r) {
        value = AddBeneficiaryStateSuccess();
      });
    }
  }

  bool get fieldsIsValid => nameError.value == null && phoneError.value == null;
}
