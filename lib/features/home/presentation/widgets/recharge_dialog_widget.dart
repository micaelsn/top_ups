import 'package:flutter/material.dart';

import '../../domain/entities/top_up_entity.dart';

class RechargeDialogWidget extends StatelessWidget {
  const RechargeDialogWidget(
      {super.key, required this.topups, required this.onTap});

  final List<TopUpEntity> topups;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: topups
            .map((topup) => Row(
                  children: [
                    Text(topup.currency),
                    Text(topup.value.toString()),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
