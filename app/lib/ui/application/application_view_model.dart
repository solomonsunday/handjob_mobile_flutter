import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/instant_job.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../models/applicant.model.dart';
import '../../services/instant_job.service.dart';

class ApplicationViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();

  List<Applicant>? get applicants => _instantJobService.applicants;
  InstantJob? get instantJob => _instantJobService.instantJob;

  goBack() => _navigationService.back();

  getApplicants(String jobId) async {
    runBusyFuture(getApplicantsRequest(jobId));
  }

  getApplicantsRequest(String jobId) async {
    setBusy(true);
    _instantJobService.clearJobApplicants();
    try {
      await _instantJobService.getInstantJob(jobId);
      await _instantJobService.getApplicants(jobId);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_instantJobService];
}
