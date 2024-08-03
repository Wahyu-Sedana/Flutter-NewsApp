import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/cores/helpers/helper.dart';
import 'package:news_app/features/home/data/models/home_model.dart';
import 'package:news_app/features/home/domain/usecase/home_usecase.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';

class HomeProvider with ChangeNotifier {
  final HomeUseCase homeUseCase;

  HomeProvider({
    required this.homeUseCase,
  });

  String? imageNews;
  String? titleNews;
  String? pubDateNews;

  List<NewsData> _listNews = [];
  List<NewsData> _listNewsPolitics = [];

  set setListNews(List<NewsData> val) {
    final titles = val.map((e) => e.title).toSet();
    final List<NewsData> uniqueNews = [];

    for (var title in titles) {
      final selectedNews = val.where((i) => i.title == title).toList();
      uniqueNews.add(NewsData(
        title: title,
        link: selectedNews.firstWhere((i) => i.title == title).link,
        isoDate: selectedNews.firstWhere((i) => i.title == title).isoDate,
        image: selectedNews.firstWhere((i) => i.title == title).image,
        description: selectedNews.firstWhere((i) => i.title == title).description,
      ));
    }

    _listNews = uniqueNews;
    notifyListeners();
  }

  set setListNewsPolitics(List<NewsData> val) {
    final titles = val.map((e) => e.title).toSet();
    final List<NewsData> uniqueNews = [];

    for (var title in titles) {
      final selectedNews = val.where((i) => i.title == title).toList();
      uniqueNews.add(NewsData(
        title: title,
        link: selectedNews.firstWhere((i) => i.title == title).link,
        isoDate: selectedNews.firstWhere((i) => i.title == title).isoDate,
        image: selectedNews.firstWhere((i) => i.title == title).image,
        description: selectedNews.firstWhere((i) => i.title == title).description,
      ));
    }

    _listNewsPolitics = uniqueNews;
    notifyListeners();
  }

  List<NewsData> get listNews => _listNews;
  List<NewsData> get listNewsPolitics => _listNewsPolitics;

  HomeState _homeState = HomeInitial();
  HomeState _homePoliticState = HomeInitial();

  HomeState get homeState => _homeState;
  HomeState get homePoliticState => _homePoliticState;

  Future<void> getNews() async {
    _homeState = HomeLoading();
    notifyListeners();
    final result = await homeUseCase.getNews();
    result.fold((failure) {
      logMe("error");
      logMe(failure);
      _homeState = HomeFailure(failure: failure);
      notifyListeners();
    }, (data) {
      if (data.isNotEmpty) {
        _homeState = HomeLoaded(data: data);
        _listNews = data;
        notifyListeners();
        return data;
      } else {
        _homeState = HomeEmpty();
        notifyListeners();
        return null;
      }
    });
  }

  Future<void> getNewsPolitic() async {
    _homePoliticState = HomeLoading();
    notifyListeners();
    final result = await homeUseCase.getNewsPolitic();
    result.fold((failure) {
      logMe("error");
      logMe(failure);
      _homePoliticState = HomeFailure(failure: failure);
      notifyListeners();
    }, (data) {
      if (data.isNotEmpty) {
        _homePoliticState = HomeLoaded(data: data);
        _listNewsPolitics = data;
        notifyListeners();
        return data;
      } else {
        _homePoliticState = HomeEmpty();
        notifyListeners();
        return null;
      }
    });
  }

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
}
