import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/applied_job.model.dart';
import '../../../../services/instant_job.service.dart';
import '../jobs_view.dart';

class JobDetailViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();

  bool _isWaitingToBeAccepted = false;
  bool get isWaitingToBeAccepted => _isWaitingToBeAccepted;

  navigateBack() => _navigationService.back();

  List<AppliedJob>? get appliedJobs => _instantJobService.appliedJobs;

  bool isJobApplied(String id) {
    return (appliedJobs ?? [])
        .where((element) => element.jobId == id)
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
}
