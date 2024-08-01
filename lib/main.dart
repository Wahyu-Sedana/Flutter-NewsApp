import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/cores/helpers/injection.dart';
import 'package:news_app/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:news_app/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:news_app/features/history/presentation/page/history_page.dart';
import 'package:news_app/features/home/presentation/page/home_page.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await locatorInit();
  try {
    runApp(const MyApp());
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        maxMobileWidth: 500,
        maxTabletWidth: 1500,
        builder: (_, orientation, screenType) => MultiProvider(
              providers: [
                ChangeNotifierProvider<DashboardProvider>(
                    create: (_) => locator<DashboardProvider>()),
                ChangeNotifierProvider<HomeProvider>(create: (_) => locator<HomeProvider>())
              ],
              builder: (context, _) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/splash',
                  routes: {
                    '/splash': (context) => const SplashPage(),
                    '/dashboard': (context) => const DashboardPage(),
                    '/home': (context) => const HomePage(),
                    '/history': (context) => const HistoryPage()
                  },
                );
              },
            ));
  }
}
