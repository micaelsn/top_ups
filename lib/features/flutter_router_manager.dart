import 'package:flutter/material.dart';

import 'add_beneficiary/presentation/pages/add_beneficiary_page.dart';
import 'home/presentation/pages/home_page.dart';

class ModuleRoutes {
  static const String home = '/';
  static const String addBeneficiary = '/add_beneficiary';
}

class FlutterRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ModuleRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
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
