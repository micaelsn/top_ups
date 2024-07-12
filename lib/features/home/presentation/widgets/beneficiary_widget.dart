import 'package:flutter/material.dart';

import '../../domain/entities/beneficiary_entity.dart';

class BeneficiaryWidget extends StatelessWidget {
  final BeneficiaryEntity beneficiary;
  final Function() onPressed;
  final double width;
  const BeneficiaryWidget({
    super.key,
    required this.beneficiary,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(top: 10.0, right: 15, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            beneficiary.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            beneficiary.phone,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text(
                'Recharge Now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
