import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../drivers/screens/drivers_list_screen.dart';
import '../../reports/screens/reports_screen.dart';
import '../../settings/screens/settings_screen.dart';
import 'dashboard_screen.dart';
import '../../violations/screens/violations_list_screen.dart';
import '../../providers/dashboard_provider.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final pages = const [
      DashboardScreen(),
      DriversListScreen(),
      ViolationsListScreen(),
      ReportsScreen(),
      SettingsScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[provider.currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: provider.currentIndex,
        onDestinationSelected: provider.setIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Drivers'),
          NavigationDestination(icon: Icon(Icons.report_outlined), selectedIcon: Icon(Icons.report), label: 'Violations'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
