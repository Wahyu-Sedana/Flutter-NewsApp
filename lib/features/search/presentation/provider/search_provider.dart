import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  set setSearchController(val) {
    _searchController.text = val;
    notifyListeners();
  }

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get searchController => _searchController;
}
