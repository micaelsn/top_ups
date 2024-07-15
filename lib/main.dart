import 'package:flutter/material.dart';
import 'features/add_beneficiary/add_beneficiary.dart';
import 'features/recharge_mobile/recharge_mobile.dart';

import 'features/app/app.dart';
import 'features/flutter_router_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _injection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top-ups',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      onGenerateRoute: FlutterRouteManager.generateRoute,
      initialRoute: ModuleRoutes.login,
    );
  }
}

void _injection() {
  appInjection();
  rechargeMobileInjection();
  addBeneficiaryInjection();
}
