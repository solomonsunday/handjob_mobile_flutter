import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/utils/contants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jobplicant-api.onrender.com',
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
    print('REquest: ${options.path}');
    options.headers['platform'] = "mobile";
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(AUTH_TOKEN_KEY) != null) {
      options.headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AUTH_TOKEN_KEY)}';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('error occured: ${err.response?.data} ');
    final DialogService dialogService = locator<DialogService>();
    final NavigationService navigationService = locator<NavigationService>();
    /**
         * // if token expires and app is unable to 
         * authorize the user's request.
         * It globally logs you out of the app
         */
    if (err.response?.statusCode == 401) {
      navigationService.navigateToAuthView();
    }
    // This is intended to intercept all 500 (internal server) related errors

    if (err.response?.statusCode == 500) {
      dialogService.showDialog(
          title: 'An error occured',
          description: "An error occured, kindly try again later");
    }

    return super.onError(err, handler);
  }
}
