import 'package:dio/dio.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';

class CustomerService {
  final Dio _dio = new Dio();

  CustomerService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }


}