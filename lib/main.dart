import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/localization/app_localizations.dart';
import 'core/themes/light_theme.dart';
import 'core/themes/dark_theme.dart';
import 'core/themes/custom_theme.dart';
import 'data/services/firebase_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/driver_repository.dart';
import 'data/repositories/violation_repository.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/drivers/providers/drivers_provider.dart';
import 'features/violations/providers/violations_provider.dart';
import 'features/reports/providers/reports_provider.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/dashboard/screens/navigation_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/auth/screens/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final settings = SettingsProvider();

  @override
  void initState() {
    super.initState();
    settings.load();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settings),
        Provider(create: (_) => AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance)),
        ChangeNotifierProvider(create: (c) => AuthProvider(c.read<AuthRepository>())),
        Provider(create: (_) => DriverRepository(FirebaseFirestore.instance)),
        ChangeNotifierProvider(create: (c) => DriversProvider(c.read<DriverRepository>())),
        Provider(create: (_) => ViolationRepository(FirebaseFirestore.instance)),
        ChangeNotifierProvider(create: (c) => ViolationsProvider(c.read<ViolationRepository>())),
        ChangeNotifierProvider(create: (_) => ReportsProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          final themeMode = settings.themeMode;
          final seed = settings.customSeed;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Traffic Violations',
            locale: settings.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            themeMode: themeMode,
            theme: buildLightTheme(themeMode == ThemeMode.system ? seed : (themeMode == ThemeMode.light ? seed : null)),
            darkTheme: buildDarkTheme(themeMode == ThemeMode.dark ? seed : null),
            routes: {
              '/login': (_) => const LoginScreen(),
              '/register': (_) => const RegisterScreen(),
              '/forgot': (_) => const ForgotPasswordScreen(),
              '/nav': (_) => const NavigationScreen(),
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), _goNext);
  }

  void _goNext() {
    final user = FirebaseAuth.instance.currentUser;
    if (!mounted) return;
    if (user == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/nav');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
