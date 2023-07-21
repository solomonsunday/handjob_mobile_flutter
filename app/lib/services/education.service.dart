import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/education.model.dart';

class EducationService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  EducationService() {
    listenToReactiveValues([]);
  }

  Future<bool> createEducation(Map formData) async {
    var response = await dioClient.post(
      '/education',
      data: formData,
    );

    return true;
  }

  Future<Education> updateEducation(String id, Map formData) async {
    var response = await dioClient.put(
      '/education/$id',
      data: formData,
    );

    return Education.fromJson(response.data);
  }

  Future<bool> deleteEducation(String id) async {
    var response = await dioClient.delete(
      '/education/$id',
    );
    return true;
  }
}
