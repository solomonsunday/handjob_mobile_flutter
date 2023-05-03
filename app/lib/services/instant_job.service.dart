import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/applied_job.model.dart';
import 'package:handjob_mobile/models/instant_job.model.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/applicant.model.dart';

class InstantJobService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  InstantJobService() {
    listenToReactiveValues([
      instantJobs,
      appliedJobs,
      instantHires,
      applicants,
      instantJob,
    ]);
  }

  final ReactiveValue<List<InstantJob>> _instantHires =
      ReactiveValue<List<InstantJob>>([]);
  final ReactiveValue<List<InstantJob>> _instantJobs =
      ReactiveValue<List<InstantJob>>([]);
  final ReactiveValue<List<AppliedJob>> _appliedJobs =
      ReactiveValue<List<AppliedJob>>([]);
  final ReactiveValue<List<Applicant>> _applicants =
      ReactiveValue<List<Applicant>>([]);
  InstantJob? _instantJob;
  List<InstantJob> get instantJobs => _instantJobs.value;
  List<InstantJob> get instantHires => _instantHires.value;
  List<AppliedJob> get appliedJobs => _appliedJobs.value;
  List<Applicant> get applicants => _applicants.value;
  InstantJob? get instantJob => _instantJob;

  Future<InstantJob> createInstantJob(Map formData) async {
    var response = await dioClient.post(
      '/instant-job',
      data: formData,
    );
    return InstantJob.fromJson(response.data);
  }

  Future<InstantJob> updateInstantJob(String id, Map formData) async {
    var response = await dioClient.put(
      '/instant-job/$id',
      data: formData,
    );
    return InstantJob.fromJson(response.data);
  }

  Future<bool> deleteInstantJob(String id) async {
    var response = await dioClient.delete(
      '/instant-job/$id',
    );
    print('response on delete instant job: ${response.data}');
    return true;
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
    return instantHires;
  }

  Future<InstantJob> getInstantJob(String id) async {
    var response = await dioClient.get('/instant-job/$id');
    InstantJob instantJob = InstantJob.fromJson(response.data);
    _instantJob = instantJob;
    return instantJob;
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

  Future<List<AppliedJob>> getApplicants(String jobId) async {
    String url = '/instant-job/$jobId/applicants';

    var response = await dioClient.get(url);
    List<Applicant> applicants = (response.data["data"] as List<dynamic>)
        .map((x) => Applicant.fromJson(x))
        .toList();
    _applicants.value = applicants;
    return appliedJobs;
  }

  clearJobApplicants() {
    _applicants.value = [];
    notifyListeners();
  }

  Future<bool> acceptApplication(
      String applicationId, Map<String, String> formData) async {
    await dioClient.put(
      '/instant-job/$applicationId/application/accept',
      data: formData,
    );
    return true;
  }

  Future<bool> rejectApplication(
      String applicationId, Map<String, String> formData) async {
    await dioClient.put(
      '/instant-job/$applicationId/application/reject',
      data: formData,
    );
    return true;
  }

  submitReview(Map<String, dynamic> formData) async {
    var response = await dioClient.post(
      '/review',
      data: formData,
    );
    print('response data: ${response.data}');
  }
}
