import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../app/app.locator.dart';
import '../../models/instant_job.model.dart';
import '../../models/lga.model.dart';
import '../../models/place.model.dart';
import '../../models/profession_type.model.dart';
import '../../models/state.model.dart';
import '../../models/suggestion.model.dart';
import '../../services/authentication.service.dart';
import '../../services/instant_job.service.dart';
import '../../services/location.service.dart';
import '../../services/shared.service.dart';
import '../../ui/main/main_view.dart';
import '../../utils/contants.dart';
import '../../utils/helpers.dart';
import '../../utils/http_exception.dart';

class EditInstantJobSheetViewModel extends BaseViewModel {
  final _locationService = locator<LocationService>(param1: const Uuid().v4());
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();
  final _sharedService = locator<SharedService>();
  final _authenticationService = locator<AuthenticationService>();

  final TextEditingController serviceNeedController = TextEditingController();
  final TextEditingController serviceLocationController =
      TextEditingController();
  TextEditingValue serviceLocationValue = TextEditingValue(text: '');
  final TextEditingController meetupLocationController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController describeServiceController =
      TextEditingController();

  List<CustomState>? get states => _sharedService.states;
  List<LGA>? get lgas => _sharedService.lgas;

  String? _selectedProfession;
  String? get selectedProfession => _selectedProfession;
  int get currentIndex => _sharedService.currentIndex;

  bool _isNow = false;
  bool get isNow => _isNow;

  bool _editServiceLocation = false;
  bool get editServiceLocation => _editServiceLocation;
  bool _editMeetupLocation = false;
  bool get editMeetupLocation => _editMeetupLocation;

  handleChangeIsNow(bool value) {
    _isNow = value;
    if (value) {
      DateFormat formatter = DateFormat('dd-MMM-yyyy');
      String formatted = formatter.format(DateTime.now());
      startDateController.text = formatted;
    } else {
      startDateController.text = "";
    }
    notifyListeners();
  }

  void handleSelectedProfession(String? value) {
    _selectedProfession = value;
    serviceNeedController.text = value ?? "";

    notifyListeners();
  }

  List<ProfessionType>? get professionTypes => _sharedService.professionTypes;
  List<String> get professions {
    return (professionTypes ?? []).map((e) => e.name ?? "").toList();
  }

  List<Suggestion> _suggestions = [];

  List<Suggestion> get suggestions => _suggestions;

  void navigateBack() => _sharedService.setCurrentIndex(MainView.HOME_VIEW);

  String? _selectedStateValue;
  String? _selectedLgaValue;
  String? get selectedStateValue => _selectedStateValue;
  String? get selectedLgaValue => _selectedLgaValue;
  List<String?> get stateNames {
    return (states ?? []).map((e) => e.name).toList();
  }

  List<String>? _lgaNames;
  List<String>? get lgaNames => _lgaNames ?? lgas!.map((e) => e.name!).toList();

  double? _lat;
  double? _lon;
  double? get lat => _lat;
  double? get lon => _lon;
  String? _id;
  String? get id => _id;

  Future<void> handleSuggestion(String text) async => runBusyFuture(
        fetchSuggestionRequest(text),
        busyObject: LOCATION_SUGGESTION_REQUEST,
      );

  Future<List<Suggestion>> fetchSuggestionRequest(String text) async {
    notifyListeners();
    setBusyForObject(LOCATION_SUGGESTION_REQUEST, true);

    try {
      _suggestions = await _locationService.fetchSuggestions(text, 'en');
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
    notifyListeners();
  }

  void updateMeetupLocation(String location) {
    meetupLocationController.text = location;
    notifyListeners();
  }

  void setSelectedState(String? value) {
    _selectedStateValue = value;

    _lgaNames = [];
    _selectedLgaValue = null;
    notifyListeners();
    CustomState customState = states!.firstWhere((element) =>
        element.name!.toLowerCase().contains(value!.toLowerCase()));
    List<LGA> foundLGAs = (lgas ?? []).where((element) {
      return element.stateId == customState.id;
    }).toList();
    _lgaNames = [
      ...(_lgaNames ?? []),
      ...foundLGAs.map((e) => e.name!).toList()
    ];
    notifyListeners();
  }

  void setSelectedLGA(String? value) {
    _selectedLgaValue = value;
    notifyListeners();
  }

  handleStartDate(String value) {
    startDateController.text = value;
    notifyListeners();
  }

  handleEndDate(String value) {
    endDateController.text = value;
    notifyListeners();
  }

  // fetchProfessionTypes() async {
  //   runBusyFuture(fetchProfessionTypesRequest(), busyObject: PROFESSION_TYPES);
  // }

  // fetchProfessionTypesRequest() async {
  //   try {
  //     await _authenticationService.getProfessionTypes();
  //   } on DioError catch (error) {
  //     throw Exception(error.response!.data["message"]);
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future updateInstantService(
      Function(SheetResponse<dynamic>)? completer) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want update this job?",
    );
    if (!response!.confirmed) return;
    runBusyFuture(updateInstantServiceTask(completer));
  }

  Future updateInstantServiceTask(completer) async {
    if (serviceNeedController.text.isEmpty ||
        serviceLocationController.text.isEmpty ||
        startDateController.text.isEmpty ||
        endDateController.text.isEmpty ||
        selectedStateValue == null ||
        selectedLgaValue == null ||
        describeServiceController.text.isEmpty) {
      _errorMessage = "Some fields are required!";
      notifyListeners();
      return;
    }

    _errorMessage = "";
    notifyListeners();

    DateFormat df = DateFormat("dd-MMM-yyyy");
    String input = df.parse(startDateController.text).toIso8601String();
    // String newDate = DateFormat.yMMMEd().format(input);

    var formData = {
      "service": serviceNeedController.text,
      "meetupLocation": meetupLocationController.text.isNotEmpty
          ? meetupLocationController.text
          : "",
      "state": selectedStateValue,
      "lga": selectedLgaValue,
      "lat": lat,
      "long": lon,

      "address": serviceLocationController.text.isEmpty
          ? meetupLocationController.text
          : serviceLocationController.text,
      "startDate": dateToIso8601String(startDateController.text),
      "now": isNow, //
      "endDate": dateToIso8601String(endDateController.text),
      "description": describeServiceController.text,
      "requesterLocation": {"lat": lat, "long": lon}
    };

    // print('form data: $formData');

    setBusy(true);
    try {
      await _instantJobService.updateInstantJob(id!, formData);
      InstantJob instantJob = await _instantJobService.getInstantJob(id!);
      completer!(SheetResponse(
        confirmed: true,
        data: instantJob,
      ));
    } on DioError catch (error) {
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
      print('place detail: ${place.toJson()}');
    } on DioError catch (e) {
      // print(e.response!.data);
    } finally {
      notifyListeners();
    }
  }

  void fetchState() async {
    try {
      await _sharedService.getStates();
    } on DioError catch (error) {}
  }

  void updateId(id) {
    _id = id;
  }

  void updateDescription(String value) {
    describeServiceController.text = value;
    notifyListeners();
  }

  void handleEditServiceLocation() {
    _editServiceLocation = !_editServiceLocation;
    print('edit service : $_editServiceLocation');
    notifyListeners();
  }

  void handleEditMeetupLocation() {
    _editMeetupLocation = !_editMeetupLocation;
    notifyListeners();
  }
}
