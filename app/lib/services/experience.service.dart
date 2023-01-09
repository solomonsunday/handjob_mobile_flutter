import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/experience.model.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/user.model.dart';

class ExperienceService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  ExperienceService() {
    listenToReactiveValues([]);
  }

  Future<Experience> createExperience(Map formData) async {
    var response = await dioClient.post(
      '/job-experience',
      data: formData,
    );

    return Experience.fromJson(response.data);
  }
}
