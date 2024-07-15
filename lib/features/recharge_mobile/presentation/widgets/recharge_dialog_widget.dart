import 'package:flutter/material.dart';

import '../../domain/entities/top_up_entity.dart';

class RechargeDialogWidget extends StatelessWidget {
  const RechargeDialogWidget(
      {super.key, required this.topups, required this.onTap});

  final List<TopUpEntity> topups;
  final void Function(TopUpEntity) onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: topups
              .map((topup) => InkWell(
                    onTap: () => {
                      Navigator.pop(context),
                      onTap(topup),
                    },
                    child: _SelectValueWidget(
                      title: '${topup.currency} ${topup.value.toString()}',
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _SelectValueWidget extends StatelessWidget {
  const _SelectValueWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Text(title,
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
