import 'package:flutter/material.dart';
import 'package:news_app/features/history/presentation/page/history_page.dart';
import 'package:news_app/features/home/presentation/page/home_page.dart';
import 'package:news_app/features/search/presentation/page/search_page.dart';

class DashboardProvider with ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomePage(), const SearchPage(), const HistoryPage()];

  int get currentIndex => _currentIndex;

  Widget get currentPage => _pages[_currentIndex];

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
