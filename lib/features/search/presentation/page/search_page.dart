import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/cores/utils/colors.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';
import 'package:news_app/features/home/presentation/widget/bottom_news_widget.dart';
import 'package:news_app/features/home/presentation/widget/top_news_widget.dart';
import 'package:news_app/features/search/presentation/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static const String routeName = "/search";

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search and Explore Today's News",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              key: searchProvider.formKey,
              onChanged: (value) async {},
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: appColor),
                labelText: 'Search for news',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColor)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appColor)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const BottomNewsWidget()
          ],
        ),
      )),
    );
  }
}
