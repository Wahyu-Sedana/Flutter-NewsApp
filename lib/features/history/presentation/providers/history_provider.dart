import 'package:flutter/material.dart';
import 'package:news_app/cores/helpers/databases.dart';

class HistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _bookmarks = [];

  List<Map<String, dynamic>> get bookmarks => _bookmarks;

  Future<void> loadBookmarks() async {
    _bookmarks = await DatabaseService().getBookmarks();
    notifyListeners();
  }

  Future<void> addBookmark(Map<String, dynamic> bookmark) async {
    await DatabaseService().insertBookmark(bookmark);
    await loadBookmarks();
  }

  Future<void> removeBookmark(int id) async {
    await DatabaseService().deleteBookmark(id);
    await loadBookmarks();
  }

  bool isBookmarkedd(String title) {
    return _bookmarks.any((bookmark) => bookmark['title'] == title);
  }
}
