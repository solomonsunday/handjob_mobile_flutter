import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/instant_job.model.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';

class InstantJobService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  InstantJobService() {
    listenToReactiveValues([
      instantJobs,
      appliedJobs,
    ]);
  }

  final ReactiveValue<List<InstantJob>> _instantJobs =
      ReactiveValue<List<InstantJob>>([]);
  final ReactiveValue<List<InstantJob>> _appliedJobs =
      ReactiveValue<List<InstantJob>>([]);

  List<InstantJob> get instantJobs => _instantJobs.value;
  List<InstantJob> get appliedJobs => _appliedJobs.value;

  Future<InstantJob> createInstantJob(Map formData) async {
    var response = await dioClient.post(
      '/instant-job',
      data: formData,
    );
    return InstantJob.fromJson(response.data);
  }

  Future<List<InstantJob>> getInstantJobs({String? search}) async {
    String url = '/instant-job';
    if (search != null) {
      url += '?search=$search';
    }
    var response = await dioClient.get(url);
    List<InstantJob> instantJobs = (response.data["data"] as List<dynamic>)
        .map((x) => InstantJob.fromJson(x))
        .toList();
    _instantJobs.value = instantJobs;
    return instantJobs;
  }

  Future<List<InstantJob>> getCurrentInstantJobs({String? search}) async {
    String url = '/instant-job/current';
    if (search != null) {
      url += '?search=$search';
    }
    var response = await dioClient.get(url);
    List<InstantJob> instantJobs = (response.data["data"] as List<dynamic>)
        .map((x) => InstantJob.fromJson(x))
        .toList();
    _instantJobs.value = instantJobs;
    return instantJobs;
  }

  Future<bool> applyInstantJob(Map formData) async {
    await dioClient.post(
      '/instant-job/apply',
      data: formData,
    );
    return true;
  }

  Future<List<InstantJob>> getAppliedJobs() async {
    String url = '/instant-job/applications/me';

    var response = await dioClient.get(url);
    List<InstantJob> instantJobs = (response.data["data"] as List<dynamic>)
        .map((x) => InstantJob.fromJson(x))
        .toList();
    _appliedJobs.value = instantJobs;
    return instantJobs;
  }
}
