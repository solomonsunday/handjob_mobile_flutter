import 'package:dio/dio.dart';
import 'package:handjob_mobile/services/instant_job.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/instant_job.model.dart';

class JobsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();

  List<InstantJob> get jobs => _instantJobService.instantJobs;

  navigateBack() => _navigationService.back();

  getInstantJobs() async {
    await runBusyFuture(getInstantJobsRequest());
  }

  Future<List<InstantJob>> getInstantJobsRequest({String? search}) async {
    setBusy(true);
    try {
      var response = await _instantJobService.getInstantJobs(search: search);
      return response;
    } on DioError catch (e) {
      throw Exception(e.response!.data["message"]);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  handleSearch(String? value) {
    runBusyFuture(getInstantJobsRequest(search: value));
  }
}
