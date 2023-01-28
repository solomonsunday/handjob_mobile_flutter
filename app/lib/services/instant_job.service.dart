import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/applied_job.model.dart';
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
      instantHires,
    ]);
  }

  final ReactiveValue<List<InstantJob>> _instantHires =
      ReactiveValue<List<InstantJob>>([]);
  final ReactiveValue<List<InstantJob>> _instantJobs =
      ReactiveValue<List<InstantJob>>([]);
  final ReactiveValue<List<AppliedJob>> _appliedJobs =
      ReactiveValue<List<AppliedJob>>([]);

  List<InstantJob> get instantJobs => _instantJobs.value;
  List<InstantJob> get instantHires => _instantHires.value;
  List<AppliedJob> get appliedJobs => _appliedJobs.value;

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
    List<InstantJob> instantHires = (response.data["data"] as List<dynamic>)
        .map((x) => InstantJob.fromJson(x))
        .toList();
    _instantHires.value = instantHires;
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

  Future<List<AppliedJob>> getAppliedJobs() async {
    String url = '/instant-job/applications/me';

    var response = await dioClient.get(url);
    List<AppliedJob> appliedJobs = (response.data["data"] as List<dynamic>)
        .map((x) => AppliedJob.fromJson(x))
        .toList();
    _appliedJobs.value = appliedJobs;
    return appliedJobs;
  }
}
