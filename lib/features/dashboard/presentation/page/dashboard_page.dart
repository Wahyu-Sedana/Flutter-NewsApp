import 'package:flutter/material.dart';
import 'package:news_app/cores/utils/colors.dart';
import 'package:news_app/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (_, provider, __) {
      return Scaffold(
        body: provider.currentPage,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: provider.currentIndex == 0 ? appColor : Colors.grey,
                onPressed: () {
                  provider.changePage(0);
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                color: provider.currentIndex == 1 ? appColor : Colors.grey,
                onPressed: () {
                  provider.changePage(1);
                },
              ),
              IconButton(
                icon: const Icon(Icons.history),
                color: provider.currentIndex == 2 ? appColor : Colors.grey,
                onPressed: () {
                  provider.changePage(2);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
