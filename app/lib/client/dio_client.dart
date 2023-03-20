import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/utils/contants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api-jobplicant.herokuapp.com',
      // connectTimeout: 15000,
      // receiveTimeout: 3000,
    ),
  )..interceptors.add(BearerTokenInterceptor());

  Dio get dio => _dio;
}

class BearerTokenInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers['platform'] = "mobile";
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(AUTH_TOKEN_KEY) != null) {
      options.headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AUTH_TOKEN_KEY)}';
    }
    print('OPTIONS: ${options.headers.toString()}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final NavigationService navigationService = locator<NavigationService>();
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if (response.statusCode == 401) {
      navigationService.navigateToAuthView();
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('err response: ${err.response?.data}');
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
