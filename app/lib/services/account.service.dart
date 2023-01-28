import 'dart:io';

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

  Future<User> updateContactInfo(Map formData) async {
    var response = await dioClient.put(
      '/accounts/contact-info',
      data: formData,
    );

    return User.fromJson(response.data);
  }

  int index = 0;

  Future<User> uploadPortfolios(List<File> files) async {
    print('files: $files');

    var formData = FormData.fromMap({
      'files': files
          .map(
            (file) =>
                MultipartFile.fromFileSync(file.path, filename: file.path),
          )
          .toList(),
    });
    print('formdata: $formData');

    var response = await dioClient.put(
      '/accounts/upload-portfolios',
      data: formData,
    );
    return User.fromJson(response.data);
  }

  Future<User> uploadPortfolio(File file) async {
    var formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(file.path, filename: file.path),
    });
    print('formdata: $formData');
    var response = await dioClient.put(
      '/accounts/upload-portfolios',
      data: formData,
    );
    return User.fromJson(response.data);
  }

  Future requestSMSOTP(String phone, String accountId) async {
    var formData = {
      "toNumbers": [phone],
      "accountId": accountId
    };
    var response = await dioClient.post(
      '/verification/send-sms-shortcode',
      data: formData,
    );
    print('sms response: ${response.data}');
    return response.data;
  }

  Future<Map> verifySMSOTP(String code) async {
    var response = await dioClient.put('/verification/phonenumber/$code');
    print('respones data ${response.data}');
    return response.data;
  }

  Future<User> uploadProfilePicture(File file) async {
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: file.path),
    });

    var response = await dioClient.put(
      '/accounts/upload-avatar',
      data: formData,
    );
    return User.fromJson(response.data);
  }
}
