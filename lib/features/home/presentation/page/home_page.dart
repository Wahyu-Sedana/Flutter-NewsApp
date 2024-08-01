import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Consumer<HomeProvider>(builder: (_, provider, __) {
        return Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Text(
                    'Breaking News',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<HomeState>(
                    stream: provider.getNews(),
                    builder: (context, state) {
                      switch (state.data.runtimeType) {
                        case HomeLoading:
                          return const Center(child: CircularProgressIndicator());
                        case HomeFailure:
                          final failure = (state.data as HomeFailure).failure;
                          Fluttertoast.showToast(msg: failure.toString());
                          return const SizedBox.shrink();
                        case HomeLoaded:
                          final _data = (state.data as HomeLoaded).data;
                          return _data.isEmpty
                              ? const Center(child: Text("No news available"))
                              : CarouselSlider.builder(
                                  itemCount: _data.length,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex, int pageViewIndex) {
                                    return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Card(
                                            child: Column(
                                          children: [
                                            Image.network(
                                              _data[itemIndex].image,
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _data[itemIndex].title,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(formatDate(
                                                      _data[itemIndex].isoDate.toString()))
                                                ],
                                              ),
                                            )
                                          ],
                                        )));
                                  },
                                  options: CarouselOptions(
                                    height: 310.0,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeFactor: 0.3,
                                    scrollDirection: Axis.horizontal,
                                  ));
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Politic',
                        style: TextStyle(
                            color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                            color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<HomeState>(
                    stream: provider.getNewsPolitic(),
                    builder: (context, state) {
                      switch (state.data.runtimeType) {
                        case HomeLoading:
                          return const Center(child: CircularProgressIndicator());
                        case HomeFailure:
                          final failure = (state.data as HomeFailure).failure;
                          Fluttertoast.showToast(msg: failure.toString());
                          return const SizedBox.shrink();
                        case HomeLoaded:
                          final _data = (state.data as HomeLoaded).data;
                          return _data.isEmpty
                              ? const Center(child: Text("No news available"))
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Card(
                                        child: ListTile(
                                          leading: Image.network(
                                            _data[index].image,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          title: Text(
                                            _data[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle:
                                              Text(formatDate(_data[index].isoDate.toString())),
                                        ),
                                      ),
                                    );
                                  },
                                );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ));
      })),
    );
  }
}
