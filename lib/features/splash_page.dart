import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/cores/utils/colors.dart';
import 'package:news_app/cores/utils/strings.dart';
import 'package:news_app/cores/utils/style.dart';
import 'package:news_app/features/dashboard/presentation/page/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, DashboardPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: appColor,
      body: Center(
        child: Text(
          appName,
          style: appNameTextStyle,
        ),
      ),
    );
  }
}
