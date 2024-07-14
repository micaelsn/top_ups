import 'package:flutter/material.dart';

// import '../../../../core/database/localstorage.dart';

class AddBeneficiaryController {
  // final LocalStorage localStorage;

  // AddBeneficiaryController({required this.localStorage});

  static const int maxNickNameLength = 20;
  static const int maxPhoneLength = 11;
  ValueNotifier<bool> isSending = ValueNotifier(false);

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

  Future<bool> send() async {
    isSending.value = true;
    sendValidate(
      name: nameController.text,
      phone: phoneController.text,
    );
    if (fieldsIsValid) {
      // await localStorage.insert('beneficiaries', {
      //   'name': nameController.text,
      //   'phone': phoneController.text,
      // });
      isSending.value = false;
      return true;
    }
    isSending.value = false;
    return false;
  }

  bool get fieldsIsValid => nameError.value == null && phoneError.value == null;
}
