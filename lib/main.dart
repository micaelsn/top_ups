import 'package:flutter/material.dart';
import 'features/recharge_mobile/recharge_mobile.dart';

import 'core/injection/app_injection.dart';
import 'features/flutter_router_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appInjection();
  rechargeMobileInjection();
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
      initialRoute: ModuleRoutes.home,
    );
  }
}
