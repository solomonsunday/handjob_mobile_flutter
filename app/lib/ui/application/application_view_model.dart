import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/instant_job.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../models/applicant.model.dart';
import '../../models/applied_job.model.dart';
import '../../services/instant_job.service.dart';

class ApplicationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();

  List<Applicant>? get applicants => _instantJobService.applicants;

  goBack() => _navigationService.back();

  getApplicants(String jobId) async {
    runBusyFuture(getApplicantsRequest(jobId));
  }

  getApplicantsRequest(String jobId) async {
    try {
      await _instantJobService.getApplicants(jobId);
    } on DioError catch (error) {}
  }
}
