import 'package:dio/dio.dart';
import 'package:news_app/cores/settings/api_setting.dart';
import 'package:news_app/cores/settings/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static late Dio _dio;
  final AppInterceptor appInterceptor = AppInterceptor();
  addInterception() {
    _dio.interceptors.addAll([appInterceptor, PrettyDioLogger(requestBody: false)]);
  }

  DioClient({String base = baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: base,
      validateStatus: (status) => (status! >= 200) && (status <= 422),
    ));
    addInterception();
  }

  Dio get dio => _dio;
}
