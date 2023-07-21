import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/service_group.model.dart';

class ExperienceService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  ExperienceService() {
    listenToReactiveValues([]);
  }

  List<ServiceGroup> _serviceGroup = [];
  List<ServiceGroup> get serviceGroup => _serviceGroup;

  Future<bool> createExperience(Map formData) async {
    var response = await dioClient.post(
      '/job-experience',
      data: formData,
    );
    return true;
  }

  Future<bool> updateExperience(String id, Map formData) async {
    var response = await dioClient.put(
      '/job-experience/$id',
      data: formData,
    );

    return true;
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
