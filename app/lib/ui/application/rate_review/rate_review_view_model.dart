import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/ui/application/rate_review/rate_review_view.form.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/instant_job.service.dart';

class RateReviewViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  goBack() => _navigationService.back();

  @override
  void setFormStatus() {
    if (nameValue!.isEmpty) {
      setNameValidationMessage("Name is required");
      _isFormValid = false;
      return;
    }

    if (titleValue!.isEmpty) {
      setTitleValidationMessage("Title is required");
      _isFormValid = false;
      return;
    }

    if (descriptionValue!.isEmpty) {
      setDescriptionValidationMessage("Description is required");
      _isFormValid = false;
      return;
    }

    _isFormValid = true;
  }

  submitReview(String applicantId, String jobId) {
    runBusyFuture(submitReviewRequest(applicantId, jobId));
  }

  submitReviewRequest(String applicantId, String jobId) async {
    if (!isFormValid) {
      Fluttertoast.showToast(
        msg: "Some fields are required",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }
    var formData = {
      'reviewerDisplayName': nameValue,
      'title': titleValue,
      'detail': descriptionValue,
      "applicantId": applicantId,
      "jobId": jobId,
      "rating": int.tryParse((ratingValue ?? "0").toString())
    };
    print('form: $formData');
    setBusy(true);
    try {
      await _instantJobService.submitReview(formData);
      Fluttertoast.showToast(
        msg: 'Review added successfully',
        toastLength: Toast.LENGTH_LONG,
      );
      _navigationService.back();
    } on DioError catch (error) {
      throw HttpException(
          error.response?.data['message'] ?? "An error occured");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}
