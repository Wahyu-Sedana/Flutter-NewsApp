import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/history/presentation/providers/history_provider.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';
import 'package:provider/provider.dart';

class TopNewsWidget extends StatefulWidget {
  const TopNewsWidget({super.key});

  @override
  State<TopNewsWidget> createState() => _TopNewsWidgetState();
}

class _TopNewsWidgetState extends State<TopNewsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, HistoryProvider>(builder: (_, provider, historyProvider, __) {
      final state = provider.homeState;
      return state is HomeLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state is HomeFailure
              ? Text(state.failure.message)
              : state is HomeLoaded
                  ? CarouselSlider.builder(
                      itemCount: provider.listNews.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                        final newsItem = provider.listNews[itemIndex];
                        final isBookmarked = historyProvider.isBookmarkedd(newsItem.title);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  newsItem.image,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsItem.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              provider.formatDate(newsItem.isoDate.toString()),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            iconSize: 20, // Ukuran ikon di sini
                                            icon: Icon(
                                              isBookmarked
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_add_outlined,
                                              size: 20, // Ukuran ikon di sini
                                            ),
                                            onPressed: () {
                                              historyProvider.addBookmark({
                                                'title': newsItem.title,
                                                'image': newsItem.image,
                                                'isoDate': newsItem.isoDate.toString(),
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 340.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Container();
    });
  }
}
