import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/cores/error/failure.dart';
import 'package:news_app/cores/settings/network_info.dart';
import 'package:news_app/features/home/data/datasource/home_datasource.dart';
import 'package:news_app/features/home/data/models/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<NewsData>>> getNews();
  Future<Either<Failure, List<NewsData>>> getNewsPolitic();
}

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeDataSource,
  });

  Failure handleError(DioException e) {
    try {
      return ServerFailure(e.response?.data['message']);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<NewsData>>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeDataSource.getNews();
        if (response.isNotEmpty) {
          return Right(response);
        } else {
          return const Left(ServerFailure('News is not available'));
        }
      } on DioException catch (e) {
        return Left(handleError(e));
      }
    } else {
      return left(const ConnectionFailure('Not Connected'));
    }
  }

  @override
  Future<Either<Failure, List<NewsData>>> getNewsPolitic() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeDataSource.getNewsPolitic();
        if (response.isNotEmpty) {
          return Right(response);
        } else {
          return const Left(ServerFailure('Politic News is not available'));
        }
      } on DioException catch (e) {
        return Left(handleError(e));
      }
    } else {
      return left(const ConnectionFailure('Not Connected'));
    }
  }
}
