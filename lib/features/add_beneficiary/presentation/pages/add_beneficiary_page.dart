import 'package:flutter/material.dart';
import 'package:top_ups/core/injection/injection.dart';

import '../controllers/add_beneficiary_controller.dart';
import '../controllers/add_beneficiary_state.dart';
import '../widgets/button_widget.dart';
import '../widgets/form_field_widget.dart';

class AddBeneficiaryPage extends StatefulWidget {
  const AddBeneficiaryPage({super.key});

  @override
  State<AddBeneficiaryPage> createState() => _AddBeneficiaryPageState();
}

class _AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  late AddBeneficiaryController controller;
  @override
  void initState() {
    controller = Injection().get<AddBeneficiaryController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Beneficiary"),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (_, state, __) {
            return switch (state) {
              AddBeneficiaryStateLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              AddBeneficiaryStateError() => const Center(
                  child: Text('Error, try agian'),
                ),
              AddBeneficiaryStateSuccess() => Center(
                  child: Text(
                      'Added ${controller.nameController.text} with success'),
                ),
              _ => _ContentWidget(
                  controller: controller,
                )
            };
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, state, __) {
              return switch (state) {
                AddBeneficiaryStateLoading() => const SizedBox(),
                AddBeneficiaryStateSuccess() => const SizedBox(),
                _ => ButtonWidget(
                    title: "Add",
                    isLoading: state is AddBeneficiaryStateLoading,
                    onPressed: controller.add,
                  )
              };
            }),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    required this.controller,
  });
  final AddBeneficiaryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: controller.nameError,
            builder: (_, value, w) {
              return FormFieldWidget(
                hint: 'Name',
                label: 'Name',
                controller: controller.nameController,
                errorText: value,
                onChanged: (text) => controller.sendValidate(name: text),
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<String?>(
            valueListenable: controller.phoneError,
            builder: (_, value, w) {
              return FormFieldWidget(
                hint: 'Phone',
                label: 'Phone',
                controller: controller.phoneController,
                errorText: value,
                onChanged: (text) => controller.sendValidate(phone: text),
              );
            },
          ),
        ],
      ),
    );
  }
}
