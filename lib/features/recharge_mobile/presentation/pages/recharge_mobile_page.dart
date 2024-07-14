import 'package:flutter/material.dart';
import 'package:top_ups/core/injection/injection.dart';
import 'package:top_ups/core/module/module_navigator.dart';

import '../../../flutter_router_manager.dart';
import '../../data/dto/top_up_dto.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../recharge_mobile.dart';
import '../controllers/recharge_mobile_controller.dart';
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
  @override
  void initState() {
    rechargeMobileInjection();
    controller = Injection().get<RechargeMobileController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
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
                    listBeneficiaries: controller.beneficiaries,
                  )),
              TabItem(
                  action: () {},
                  title: 'History',
                  widget: ListContentWidget(
                    listBeneficiaries: controller.beneficiaries,
                  )),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => ModuleNavigator().push(
                context,
                ModuleRoutes.addBeneficiary,
              )),
    );
  }
}

class ListContentWidget extends StatelessWidget {
  ListContentWidget({super.key, required this.listBeneficiaries});
  final List<BeneficiaryEntity> listBeneficiaries;
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
                              onTap: () {},
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
