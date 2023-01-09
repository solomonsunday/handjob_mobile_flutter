import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/user.model.dart';

class AccountService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  AccountService() {
    listenToReactiveValues([]);
  }

  Future<User> updateServices(Map formData) async {
    var response = await dioClient.put(
      '/accounts/services',
      data: formData,
    );
    return User.fromJson(response.data);
  }
}
