import 'package:flutter/material.dart';
import 'package:top_ups/core/injection/injection.dart';
import 'package:top_ups/core/module/module_navigator.dart';
import 'package:top_ups/features/app/presentation/controllers/app_controller.dart';

import '../../../app/domain/entities/transition_entity.dart';
import '../../../flutter_router_manager.dart';
import '../../data/dto/top_up_dto.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../controllers/recharge_mobile_controller.dart';
import '../controllers/recharge_mobile_state.dart';
import '../widgets/beneficiary_widget.dart';
import '../widgets/recharge_dialog_widget.dart';
import '../widgets/tab_view_widget.dart';

class RechargeMobilePage extends StatefulWidget {
  const RechargeMobilePage({
    super.key,
  });

  @override
  State<RechargeMobilePage> createState() => _RechargeMobilePageState();
}

class _RechargeMobilePageState extends State<RechargeMobilePage> {
  late RechargeMobileController controller;
  late AppController appController;
  @override
  void initState() {
    controller = Injection().get<RechargeMobileController>();
    appController = Injection().get<AppController>();
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
      ),
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (_, state, ___) => switch (state) {
                RechargeMobileStateInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                RechargeMobileStateError() => const Center(
                    child: Text('Ops, try again later...'),
                  ),
                RechargeMobileStateSuccess(:final beneficiaries) =>
                  _ContentWidget(
                    beneficiaries: beneficiaries,
                    appController: appController,
                    controller: controller,
                  ),
                _ => const SizedBox()
              }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => ModuleNavigator().push(
                context,
                ModuleRoutes.addBeneficiary,
              )),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    required this.beneficiaries,
    required this.appController,
    required this.controller,
  });
  final AppController appController;
  final RechargeMobileController controller;
  final List<BeneficiaryEntity> beneficiaries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Mobile Recharge',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: Colors.blueGrey),
          ),
        ),
        TabViewWidget(
          tabs: [
            TabItem(
              action: () {},
              title: 'Recharge',
              widget: ListContentWidget(
                listBeneficiaries: beneficiaries,
                onTap: (value, id) {
                  controller.recharge(value, id);
                },
              ),
            ),
            TabItem(
              action: () {},
              title: 'History',
              widget: ValueListenableBuilder(
                  valueListenable: appController.user,
                  builder: (_, user, __) {
                    return TransitionsListWidget(
                      transitions: user.transitions,
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}

class ListContentWidget extends StatelessWidget {
  ListContentWidget(
      {super.key, required this.listBeneficiaries, required this.onTap});

  final List<BeneficiaryEntity> listBeneficiaries;
  final void Function(double, String) onTap;
  final topups = [
    TopUpDTO(currency: 'AED', value: 5),
    TopUpDTO(currency: 'AED', value: 10),
    TopUpDTO(currency: 'AED', value: 20),
    TopUpDTO(currency: 'AED', value: 30),
    TopUpDTO(currency: 'AED', value: 50),
    TopUpDTO(currency: 'AED', value: 75),
    TopUpDTO(currency: 'AED', value: 100),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .4;
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listBeneficiaries.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final beneficiary = listBeneficiaries[index];
              return Container(
                margin: index == 0
                    ? const EdgeInsets.only(
                        left: 10,
                        right: 5.0,
                        top: 5.0,
                        bottom: 5.0,
                      )
                    : const EdgeInsets.all(5.0),
                height: 160,
                child: BeneficiaryWidget(
                  width: width - 10,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => RechargeDialogWidget(
                              topups: topups,
                              onTap: (topup) {
                                onTap(topup.value, beneficiary.id);
                              },
                            ));
                  },
                  beneficiary: beneficiary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TransitionsListWidget extends StatelessWidget {
  const TransitionsListWidget({super.key, required this.transitions});
  final List<TransitionEntity> transitions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: transitions
            .map((transition) => _TransitionWidget(
                  type: transition.type,
                  value: transition.value.toString(),
                ))
            .toList(),
      ),
    );
  }
}

class _TransitionWidget extends StatelessWidget {
  const _TransitionWidget({
    required this.type,
    required this.value,
  });

  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Colors.blueGrey,
              )),
          Text(value,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Colors.blueGrey,
              )),
        ],
      ),
    );
  }
}
