import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/features/home/presentation/page/home_page.dart';
import 'package:news_app/features/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {'/splash': (context) => const SplashPage(), '/home': (context) => const HomePage()},
    );
  }
}
