import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/state.model.dart' as HandjobState;
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:handjob_mobile/sheets/profile_contact/profile_contact.sheet.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';
import 'package:uuid/uuid.dart';

import '../../models/lga.model.dart';
import '../../models/place.model.dart';
import '../../models/state.model.dart';
import '../../models/suggestion.model.dart';
import '../../services/account.service.dart';
import '../../services/location.service.dart';
import '../../utils/contants.dart';
import '../../utils/http_exception.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'phone'),
  FormTextField(name: 'address')
])
class ProfileContactSheet extends StatelessWidget with $ProfileContactSheet {
  ProfileContactSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  static String _displayStringForOption(Suggestion option) =>
      option.description;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileContactSheetViewModel>.reactive(
        viewModelBuilder: () => ProfileContactSheetViewModel(),
        onModelReady: (model) => listenToFormUpdated(model),
        onDispose: (model) => disposeForm(),
        builder: (context, model, child) {
          // print('states fetched: ${model.stateList}');
          return BottomSheetContainer(
            onClose: () => completer!(SheetResponse(confirmed: false)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.phone,
                      color: ColorManager.kSecondaryColor,
                    ),
                    SizedBox(width: AppSize.s12),
                    Text('Contact Information'),
                  ],
                ),
                const SizedBox(height: AppSize.s24),
                InputField(
                  label: 'Email address',
                  hintText: 'johndemola@gmail.com',
                  fillColor: ColorManager.kWhiteColor,
                  controller: emailController,
                  focusnode: emailFocusNode,
                ),
                const SizedBox(height: AppSize.s12),
                InputField(
                  label: 'Phone number',
                  hintText: 'Enter phone number',
                  fillColor: ColorManager.kWhiteColor,
                  controller: phoneController,
                  focusnode: phoneFocusNode,
                ),
                const SizedBox(height: AppSize.s12),
                Column(
                  children: [
                    DefaultDropDownField(
                      label: 'State',
                      hint: 'Enter',
                      dropdownItems:
                          (model.stateList ?? []).map((e) => e.name!).toList(),
                      onChanged: model.handleSelectedState,
                      value: model.selectedState,
                      buttonWidth: MediaQuery.of(context).size.width,
                      buttonHeight: 50,
                      buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorManager.kDarkColor,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.s8),
                      ),
                      dropdownWidth: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(height: AppSize.s12),
                    DefaultDropDownField(
                      label: 'LGA',
                      hint: 'Enter',
                      dropdownItems: model.lgas ?? [],
                      onChanged: model.handleSelectedLGA,
                      value: model.selectedLGA,
                      buttonHeight: 50,
                      buttonWidth: MediaQuery.of(context).size.width,
                      buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorManager.kDarkColor,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.s8),
                      ),
                      dropdownWidth: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s12),
                Row(
                  children: [
                    Expanded(
                      child: Autocomplete<Suggestion>(
                        displayStringForOption: _displayStringForOption,
                        optionsBuilder:
                            (TextEditingValue textEditingValue) async {
                          if (textEditingValue.text == '') {
                            return const Iterable<Suggestion>.empty();
                          }
                          await model.handleSuggestion(textEditingValue.text);

                          return model.suggestions.where((Suggestion option) {
                            return option.description
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (Suggestion selection) async {
                          debugPrint(
                              'You just selected ${_displayStringForOption(selection)}');

                          model.updateLocation(
                              _displayStringForOption(selection));
                          await model.updateCoordinate(selection.placeId);
                        },
                        fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) =>
                            InputField(
                          label: 'Address',
                          controller: textEditingController,
                          focusnode: focusNode,
                          onTap: onFieldSubmitted,
                          fillColor: ColorManager.kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (model.hasError)
                  Text(
                    '${model.modelError}',
                    style: getRegularStyle(
                      color: ColorManager.kRed,
                      fontSize: 14,
                    ),
                  ),
                const SizedBox(height: AppSize.s24),
                DefaultButton(
                  onPressed:
                      model.isBusy || model.busy(LOCATION_SUGGESTION_REQUEST)
                          ? () {}
                          : () => model.updateContact(completer),
                  title: 'Save changes',
                  busy: model.isBusy,
                  disabled:
                      model.busy(LOCATION_SUGGESTION_REQUEST) || model.isBusy,
                ),
              ],
            ),
          );
        });
  }
}

class ProfileContactSheetViewModel extends FormViewModel {
  final _sharedService = locator<SharedService>();
  final _accountService = locator<AccountService>();
  String? _state;
  String? _lga;
  String? _selectedState;
  String? _selectedLGA;

  String? get selectedState => _selectedState;
  String? get selectedLGA => _selectedLGA;

  // List<String>? _states = [];
  // List<String>? get states => _states;
  List<CustomState>? get stateList => _sharedService.states;

  List<LGA>? get lgaList => _sharedService.lgas;
  List<String>? _lgas;
  List<String>? get lgas => _lgas;

  handleSelectedState(String? value) async {
    _selectedState = value;

    _lgas = [];
    CustomState customState = stateList!.firstWhere((element) =>
        element.name!.toLowerCase().contains(value!.toLowerCase()));
    List<LGA> foundLGAs = (lgaList ?? []).where((element) {
      return element.stateId == customState.id;
    }).toList();
    _lgas = [...(_lgas ?? []), ...foundLGAs.map((e) => e.name!).toList()];
    notifyListeners();
  }

  handleSelectedLGA(String? value) {
    _selectedLGA = value;

    notifyListeners();
  }

  updateContact(Function(SheetResponse<dynamic>)? completer) {
    runBusyFuture(
      updateContactRequest(completer),
    );
  }

  updateContactRequest(completer) async {
    var formData = {
      "phoneNumber": phoneValue,
      "email": emailValue,
      "stateId": stateList!
          .firstWhere((element) => element.name!
              .toLowerCase()
              .contains(selectedState!.toLowerCase()))
          .id!,
      "lgaId": lgaList!
          .firstWhere((element) =>
              element.name!.toLowerCase().contains(selectedLGA!.toLowerCase()))
          .id!,
      "region": regionController.text,
      "address": addressController.text,
      "long": lon,
      "lat": lat,
      "postalCode": int.parse(postalCode ?? '0'),
    };
    print('form data: $formData');

    setBusy(true);
    try {
      await _accountService.updateContactInfo(formData);
      completer!(SheetResponse(confirmed: true));
    } on DioError catch (error) {
      print('eror: ${error.response!.data}');
      throw HttpException("An error occured ${error.response!}");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  //
  final _locationService = locator<LocationService>(param1: const Uuid().v4());
  List<Suggestion> _suggestions = [];
  List<Suggestion> get suggestions => _suggestions;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

  double? _lat;
  double? _lon;
  String? _postalCode;
  double? get lat => _lat;
  double? get lon => _lon;
  String? get postalCode => _postalCode;

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
    addressController.text = location;
  }

  Future<void> updateCoordinate(String placeId) async {
    try {
      setBusyForObject(LOCATION_SUGGESTION_REQUEST, true);
      Place place = await _locationService.getPlaceDetailFromId(placeId);
      _lat = place.lat;
      _lon = place.lon;
      _postalCode = place.zipCode;
      regionController.text = place.street!;
    } on DioError catch (e) {
      print(e.response!.data);
    } finally {
      setBusyForObject(LOCATION_SUGGESTION_REQUEST, false);
    }
  }
}
