import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/dashboard/presentation/provider/dashboard_provider.dart';

final locator = GetIt.instance;

Future<void> locatorInit() async {
  // external
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey<NavigatorState>());

  // provider
  locator.registerFactory<DashboardProvider>(() => DashboardProvider());
}
