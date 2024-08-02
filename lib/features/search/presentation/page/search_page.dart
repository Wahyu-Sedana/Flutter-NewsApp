import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/cores/utils/colors.dart';
import 'package:news_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Consumer2<HomeProvider, SearchProvider>(builder: (_, provider, searchProvider, __) {
          return Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
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
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide(color: appColor)),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide(color: appColor))),
                    ),
                    const SizedBox(
                      height: 10,
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
                                              height: 300,
                                              fit: BoxFit.cover,
                                            ),
                                            title: Text(
                                              _data[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle:
                                                Text(formatDate(_data[index].isoDate.toString())),
                                            trailing: const Icon(Icons.bookmark_add_outlined),
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
        }),
      ),
    );
  }
}
