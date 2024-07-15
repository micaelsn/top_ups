import 'package:flutter/material.dart';
import 'package:top_ups/core/injection/injection.dart';
import 'package:top_ups/core/module/module_navigator.dart';
import 'package:top_ups/features/app/domain/entities/user_entity.dart';
import 'package:top_ups/features/home/presentation/widgets/option_widget.dart';

import '../../../app/presentation/controllers/app_controller.dart';
import '../../../flutter_router_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserEntity user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppController controller;
  @override
  void initState() {
    controller = Injection().get<AppController>();
    controller.init(widget.user);
    super.initState();
  }

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
            Text(
              'Welcome, ${controller.userName}',
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
                valueListenable: controller.user,
                builder: (_, user, __) {
                  return Text(
                    user.balance.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: Colors.grey),
                  );
                }),
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
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
