import 'package:flutter/material.dart';

import '../../domain/entities/beneficiary_entity.dart';

class BeneficiaryWidget extends StatelessWidget {
  final BeneficiaryEntity beneficiary;
  const BeneficiaryWidget({
    super.key,
    required this.beneficiary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, right: 15, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            beneficiary.name,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            beneficiary.phone,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text(
                'Recharge Now',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
