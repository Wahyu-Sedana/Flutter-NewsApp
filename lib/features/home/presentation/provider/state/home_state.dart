import 'package:equatable/equatable.dart';
import 'package:news_app/cores/error/failure.dart';
import 'package:news_app/features/home/data/models/home_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<NewsData> data;

  HomeLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

// class HomeTitleLoaded extends HomeState {
//   final HomeModel data;

//   HomeTitleLoaded({required this.data});

//   @override
//   List<Object?> get props => [data];
// }

class HomeFailure extends HomeState {
  final Failure failure;

  HomeFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
