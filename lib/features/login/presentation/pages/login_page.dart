import 'package:flutter/material.dart';
import 'package:top_ups/core/module/module_navigator.dart';
import 'package:top_ups/features/app/data/dtos/user_dto.dart';
import 'package:top_ups/features/flutter_router_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ModuleNavigator().push(context, ModuleRoutes.home,
                    arg: UserDTO(
                        name: 'Micael',
                        balance: 4000,
                        token: '###',
                        transitions: []));
              },
              child: const Text(
                'Verified Client',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    color: Colors.blueGrey),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ModuleNavigator().push(context, ModuleRoutes.home,
                    arg: UserDTO(
                      name: 'User',
                      balance: 5000,
                      transitions: [],
                    ));
              },
              child: const Text(
                'Not Verified Client',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
