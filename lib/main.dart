import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/add_beneficiary/add_beneficiary.dart';
import 'features/recharge_mobile/recharge_mobile.dart';

import 'features/app/app.dart';
import 'features/flutter_router_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
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

Future<void> _init() async {
  await Hive.initFlutter();
  appInjection();
  rechargeMobileInjection();
  addBeneficiaryInjection();
}
