import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/cores/utils/colors.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/search/presentation/provider/search_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  static const String routeName = "/search";

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<HomeProvider, SearchProvider>(builder: (_, provider, searchProvider, __) {
          return Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Find Your Saved News Right Now!",
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Expanded(
                  child: Center(
                    child: Text('No Data Available'),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
