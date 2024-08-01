import 'package:dartz/dartz.dart';
import 'package:news_app/cores/error/failure.dart';
import 'package:news_app/features/home/data/models/home_model.dart';
import 'package:news_app/features/home/data/repository/home_repository.dart';

abstract class HomeUseCase {
  Future<Either<Failure, List<NewsData>>> getNews();
  Future<Either<Failure, List<NewsData>>> getNewsPolitic();
}

class GetNewsUseCase implements HomeUseCase {
  final HomeRepository homeRepository;

  GetNewsUseCase({
    required this.homeRepository,
  });

  @override
  Future<Either<Failure, List<NewsData>>> getNews() async {
    return await homeRepository.getNews();
  }

  @override
  Future<Either<Failure, List<NewsData>>> getNewsPolitic() async {
    return await homeRepository.getNewsPolitic();
  }
}
