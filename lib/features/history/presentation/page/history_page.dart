import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/cores/utils/colors.dart';
import 'package:news_app/features/history/presentation/providers/history_provider.dart';
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
      body: SafeArea(child: Consumer2<SearchProvider, HistoryProvider>(
          builder: (_, searchProvider, bookmarkprovider, __) {
        return Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Find the News You've Saved!",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                key: searchProvider.formKey,
                onChanged: (value) async {
                  // homeProvider.searchNews(value);
                },
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
              Expanded(
                  child: bookmarkprovider.bookmarks.isEmpty
                      ? const Center(child: Text('No bookmarks are available'))
                      : ListView.builder(
                          itemCount: bookmarkprovider.bookmarks.length,
                          itemBuilder: (context, index) {
                            final bookmark = bookmarkprovider.bookmarks[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                child: ListTile(
                                  leading: Image.network(
                                    bookmark['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    bookmark['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(formatDate(bookmark['isoDate'])),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      bookmarkprovider.removeBookmark(bookmark['id']);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
            ],
          ),
        );
      })),
    );
  }
}
