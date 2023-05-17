import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/applicant.model.dart';
import '../../../../models/applied_job.model.dart';
import '../../../../models/user.model.dart';
import '../../../../services/authentication.service.dart';
import '../../../../services/instant_job.service.dart';
import '../jobs_view.dart';

const String FETCH_APPLICANTS = 'FETCH_APPLICANTS';

class JobDetailViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();

  bool _isWaitingToBeAccepted = false;
  bool get isWaitingToBeAccepted => _isWaitingToBeAccepted;
  User? get currentUser => _authenticationService.currentUser;
  int _applicantCount = 0;
  int get applicantCount => _applicantCount;

  navigateBack() => _navigationService.back();

  List<AppliedJob>? get appliedJobs => _instantJobService.appliedJobs;

  bool isJobApplied(String id) {
    print(
        'appliedJobs: ${(appliedJobs ?? []).where((element) => element.jobId == id).toList().isNotEmpty}');
    return (appliedJobs ?? [])
        .where((element) {
          print(
              'element.jobId == id: ${element.jobId == id} ${element.jobId} == $id');
          return element.jobId == id;
        })
        .toList()
        .isNotEmpty;
  }

  Future applyInstantJob(String jobId) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want to apply for this job?",
    );
    if (!response!.confirmed) return;

    try {
      setBusyForObject(APPLY_JOB, true);
      await _instantJobService.applyInstantJob({"jobId": jobId});
      await _instantJobService.getCurrentInstantJobs();
      Fluttertoast.showToast(
        msg: 'Job applied successfully!',
        toastLength: Toast.LENGTH_LONG,
        fontSize: FontSize.s16,
      );
      _isWaitingToBeAccepted = true;
    } on DioError catch (error) {
      print('error.response?.data: ${error.response?.data}');
      _isWaitingToBeAccepted = false;
      _dialogService.showDialog(
        description: "Unable to apply for this job. please try again",
        title: "An error occured",
      );
      // throw HttpException(error.response?.data['message'] ?? "");
    } finally {
      setBusyForObject(APPLY_JOB, false);
      notifyListeners();
    }
  }

  void fetchAppliedJobs() async {
    print('fetching jobs');
    try {
      await _instantJobService.getAppliedJobs();
    } catch (e) {
      print('error fetching applied jobs');
    }
  }

  void getApplicants(String jobId) async {
    setBusyForObject(FETCH_APPLICANTS, true);
    try {
      List<Applicant> applicants =
          await _instantJobService.getApplicants(jobId);
      _applicantCount = applicants.length;
    } catch (e) {
      print('error: $e');
    } finally {
      setBusyForObject(FETCH_APPLICANTS, false);
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_instantJobService];
}
