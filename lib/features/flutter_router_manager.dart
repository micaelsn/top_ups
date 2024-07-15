import 'package:flutter/material.dart';
import 'package:top_ups/features/login/presentation/pages/login_page.dart';
import 'package:top_ups/features/recharge_mobile/presentation/pages/recharge_mobile_page.dart';

import 'add_beneficiary/presentation/pages/add_beneficiary_page.dart';
import 'app/domain/entities/user_entity.dart';
import 'home/presentation/pages/home_page.dart';

class ModuleRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String rechargeMobile = '/recharge_mobile';
  static const String addBeneficiary = '/add_beneficiary';
}

class FlutterRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ModuleRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case ModuleRoutes.home:
        return MaterialPageRoute(
            builder: (_) => HomePage(
                  user: settings.arguments as UserEntity,
                ));
      case ModuleRoutes.rechargeMobile:
        return MaterialPageRoute(builder: (_) => const RechargeMobilePage());
      case ModuleRoutes.addBeneficiary:
        return MaterialPageRoute(builder: (_) => const AddBeneficiaryPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Page Error'),
        ),
        body: const Center(
          child: Text('Route not found.'),
        ),
      );
    });
  }
}
