import 'package:dio/dio.dart';
import 'package:news_app/cores/settings/api_setting.dart';
import 'package:news_app/features/home/data/models/home_model.dart';

abstract class HomeDataSource {
  Future<List<NewsData>> getNews();
  Future<List<NewsData>> getNewsPolitic();
}

class HomeDataSourceImpl extends HomeDataSource {
  final Dio dio;
  HomeDataSourceImpl({required this.dio});

  @override
  Future<List<NewsData>> getNews() async {
    String path = '$baseUrl/antara-news/terkini';
    try {
      final response = await dio.get(path);
      final model = NewsResponse.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NewsData>> getNewsPolitic() async {
    String path = '$baseUrl/antara-news/politik';
    try {
      final response = await dio.get(path);
      final model = NewsResponse.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
