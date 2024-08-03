import 'package:flutter/material.dart';
import 'package:news_app/features/history/presentation/providers/history_provider.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';
import 'package:provider/provider.dart';

class BottomNewsWidget extends StatefulWidget {
  const BottomNewsWidget({super.key});

  @override
  State<BottomNewsWidget> createState() => _BottomNewsWidgetState();
}

class _BottomNewsWidgetState extends State<BottomNewsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().getNewsPolitic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, HistoryProvider>(builder: (_, provider, historyProvider, __) {
      final state = provider.homePoliticState;
      return state is HomeLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state is HomeFailure
              ? Text(state.failure.message)
              : state is HomeLoaded
                  ? Expanded(
                      child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: provider.listNewsPolitics.length,
                      itemBuilder: (context, index) {
                        final newsItem = provider.listNewsPolitics[index];
                        final isBookmarked = historyProvider.isBookmarkedd(newsItem.title);
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                provider.listNewsPolitics[index].image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                provider.listNewsPolitics[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(provider
                                  .formatDate(provider.listNewsPolitics[index].isoDate.toString())),
                              trailing: IconButton(
                                icon: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
                                ),
                                onPressed: () {
                                  historyProvider.addBookmark({
                                    'title': newsItem.title,
                                    'image': newsItem.image,
                                    'isoDate': newsItem.isoDate.toString(),
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  : Container();
    });
  }
}
