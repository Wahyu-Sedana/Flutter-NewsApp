import 'package:flutter/material.dart';
import 'package:news_app/cores/helpers/helper.dart';
import 'package:news_app/features/home/domain/usecase/home_usecase.dart';
import 'package:news_app/features/home/presentation/provider/state/home_state.dart';

class HomeProvider with ChangeNotifier {
  final HomeUseCase homeUseCase;

  HomeProvider({
    required this.homeUseCase,
  });

  Stream<HomeState> getNews() async* {
    yield HomeLoading();
    final result = await homeUseCase.getNews();
    yield* result.fold((failure) async* {
      logMe("error");
      logMe(failure);
      yield HomeFailure(failure: failure);
    }, (data) async* {
      yield HomeLoaded(data: data);
    });
  }

  Stream<HomeState> getNewsPolitic() async* {
    yield HomeLoading();
    final result = await homeUseCase.getNewsPolitic();
    yield* result.fold((failure) async* {
      logMe("error");
      logMe(failure);
      yield HomeFailure(failure: failure);
    }, (data) async* {
      yield HomeLoaded(data: data);
    });
  }
}
