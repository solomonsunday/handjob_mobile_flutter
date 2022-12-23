import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/services/instant_job.service.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../../models/place.model.dart';
import '../../../models/suggestion.model.dart';
import '../../../services/location.service.dart';
import '../../../services/shared.service.dart';
import '../../../utils/http_exception.dart';

const String LOCATION_SUGGESTION_REQUEST = 'LOCATION_SUGGESTION_REQUEST';

class InstantHireViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _locationService = locator<LocationService>(param1: const Uuid().v4());
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();
  final _sharedService = locator<SharedService>();

  final TextEditingController serviceNeedController = TextEditingController();
  final TextEditingController serviceLocationController =
      TextEditingController();
  final TextEditingController meetupLocationController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController describeServiceController =
      TextEditingController();

  List<Suggestion> _suggestions = [];

  List<Suggestion> get suggestions => _suggestions;

  void navigateBack() => _navigationService.back();

  String? _selectedStateValue;
  String? _selectedLgaValue;
  String? get selectedStateValue => _selectedStateValue;
  String? get selectedLgaValue => _selectedLgaValue;
  List<String> _states = ["Abia", "Anambra"];
  List<String> get states => _states;
  List<String> _lgas = ["Ibeju Lekki", "Alimosho"];
  List<String> get lgas => _lgas;

  double? _lat;
  double? _lon;
  double? get lat => _lat;
  double? get lon => _lon;

  Future<void> handleSuggestion(String text) async => runBusyFuture(
        fetchSuggestionRequest(text),
        busyObject: LOCATION_SUGGESTION_REQUEST,
      );

  Future<List<Suggestion>> fetchSuggestionRequest(String text) async {
    notifyListeners();
    setBusyForObject(LOCATION_SUGGESTION_REQUEST, true);

    try {
      _suggestions = await _locationService.fetchSuggestions(text, 'en');
      print(
          'json suggestions: ${_suggestions.map((e) => e.toJson()).toList()}');
      return _suggestions;
    } on DioError catch (e) {
      throw HttpException(e.response!.data);
    } finally {
      notifyListeners();
      setBusyForObject(LOCATION_SUGGESTION_REQUEST, false);
    }
  }

  void updateLocation(String location) {
    serviceLocationController.text = location;
  }

  void updateMeetupLocation(String location) {
    meetupLocationController.text = location;
  }

  void setSelectedState(String? value) {
    _selectedStateValue = value;
    notifyListeners();
  }

  void setSelectedLGA(String? value) {
    _selectedLgaValue = value;
    notifyListeners();
    ;
  }

  handleStartDate(String value) {
    startDateController.text = value;
    notifyListeners();
  }

  handleEndDate(String value) {
    endDateController.text = value;
    notifyListeners();
  }

  Future requestInstantService() async {
    runBusyFuture(requestInstantServiceTask());
  }

  Future requestInstantServiceTask() async {
    DateFormat df = DateFormat("dd-MMM-yyyy");
    String input = df.parse(startDateController.text).toIso8601String();
    // String newDate = DateFormat.yMMMEd().format(input);

    print('new date: $input');
    var formData = {
      "service": serviceNeedController.text,
      "meetupLocation": serviceLocationController.text,
      "lat": lat,
      "long": lon,
      "state": selectedStateValue,
      "lga": selectedLgaValue,
      "address": meetupLocationController.text.isNotEmpty
          ? meetupLocationController.text
          : serviceLocationController.text,
      "startDate": dateToIso8601String(startDateController.text),
      "now": false, //
      "endDate": dateToIso8601String(endDateController.text),
      "description": describeServiceController.text,
      "requesterLocation": {"lat": lat, "long": lon}
    };

    // print('form data: $formData');

    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want post this job?",
    );
    if (!response!.confirmed) return;
    print('proceed');
    setBusy(true);
    try {
      var response = await _instantJobService.createInstantJob(formData);
      _sharedService.setCurrentIndex(MainView.JOB_VIEW);
    } on DioError catch (error) {
      print(error.response!.data["message"]);
      throw HttpException(error.response!.data["message"]);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> updateCoordinate(String placeId) async {
    try {
      Place place = await _locationService.getPlaceDetailFromId(placeId);
      _lat = place.lat;
      _lon = place.lon;
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }
}
