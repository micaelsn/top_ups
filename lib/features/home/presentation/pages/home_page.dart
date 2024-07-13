import 'package:flutter/material.dart';
import 'package:top_ups/core/module/module_navigator.dart';
import 'package:top_ups/features/home/presentation/widgets/option_widget.dart';

import '../../../flutter_router_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, User',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            const Text(
              '1,000',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Current Balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Text(
              'More Options',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey),
            ),
            const SizedBox(height: 8),
            OptionWidget(
                title: 'Recharge',
                onTap: () {
                  ModuleNavigator().push(
                    context,
                    ModuleRoutes.rechargeMobile,
                  );
                })
          ],
        ),
      ),
    );
  }
}
