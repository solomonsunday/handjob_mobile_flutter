import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/experience.model.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/service_group.model.dart';
import '../models/user.model.dart';

class ExperienceService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  ExperienceService() {
    listenToReactiveValues([]);
  }

  List<ServiceGroup> _serviceGroup = [];
  List<ServiceGroup> get serviceGroup => _serviceGroup;

  Future<Experience> createExperience(Map formData) async {
    var response = await dioClient.post(
      '/job-experience',
      data: formData,
    );

    return Experience.fromJson(response.data);
  }

  Future<Experience> updateeExperience(String id, Map formData) async {
    var response = await dioClient.put(
      '/job-experience/$id',
      data: formData,
    );

    return Experience.fromJson(response.data);
  }

  Future<bool> deleteExperience(String id) async {
    var response = await dioClient.delete(
      '/job-experience/$id',
    );
    print('response: ${response.data}');
    return true;
  }

  Future<List<ServiceGroup>> getServiceGroup() async {
    var response = await dioClient.get("/service-group");
    print('service group response: ${response.data}');

    _serviceGroup = (response.data["data"] as List<dynamic>)
        .map((e) => ServiceGroup.fromJson(e))
        .toList();
    notifyListeners();
    return _serviceGroup;
  }
}
