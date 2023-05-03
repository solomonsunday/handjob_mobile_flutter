import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/services/instant_job.service.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../app/app.locator.dart';
import '../../../models/instant_job.model.dart';
import '../../../models/user.model.dart';
import '../../../services/authentication.service.dart';
import '../../../services/shared.service.dart';
import '../main_view.dart';

class JobsViewModel extends BaseViewModel {
  final _instantJobService = locator<InstantJobService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();

  List<InstantJob> get jobs => _instantJobService.instantJobs;

  User? get currentUser => _authenticationService.currentUser;

  void navigateBack() => _sharedService.setCurrentIndex(MainView.HOME_VIEW);

  getInstantJobs() async {
    await runBusyFuture(getInstantJobsRequest());
  }

  Future<List<InstantJob>> getInstantJobsRequest({String? search}) async {
    setBusy(true);
    try {
      var response =
          await _instantJobService.getCurrentInstantJobs(search: search);
      await _instantJobService.getAppliedJobs();

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
