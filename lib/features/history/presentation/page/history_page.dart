import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/history/presentation/providers/history_provider.dart';
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
        child: Consumer<HistoryProvider>(
          builder: (_, bookmarkProvider, __) {
            if (bookmarkProvider.bookmarks.isEmpty) {
              return const Center(child: Text("No bookmarks available"));
            } else {
              return ListView.builder(
                itemCount: bookmarkProvider.bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = bookmarkProvider.bookmarks[index];
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
                            bookmarkProvider.removeBookmark(bookmark['id']);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
