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

import '../../models/lga.model.dart';
import '../../models/state.model.dart';

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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileContactSheetViewModel>.reactive(
        viewModelBuilder: () => ProfileContactSheetViewModel(),
        onModelReady: (model) => listenToFormUpdated(model),
        onDispose: (model) => disposeForm(),
        builder: (context, model, child) {
          print('states fetched: ${model.states}');
          print('states fetched: ${model.stateList}');
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
                      dropdownItems: model.states ?? [],
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
                      dropdownItems: model.lgas.map((e) => e!).toList(),
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
                Textarea(
                  label: 'Address',
                  hintText: 'Enter',
                  fillColor: ColorManager.kWhiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(height: AppSize.s24),
                DefaultButton(onPressed: () {}, title: 'Save changes')
              ],
            ),
          );
        });
  }
}

class ProfileContactSheetViewModel extends FormViewModel {
  final _sharedService = locator<SharedService>();
  String? _state;
  String? _lga;
  String? _selectedState;
  String? _selectedLGA;

  String? get selectedState => _selectedState;
  String? get selectedLGA => _selectedLGA;

  List<String>? _states = [];
  List<String>? get states => _states;
  List<CustomState>? get stateList => _sharedService.states;

  List<LGA>? get lgaList => _sharedService.lgas;
  List<String?> get lgas => lgaList?.map((e) => e.name).toList() ?? [];

  handleSelectedState(String? value) async {
    _selectedState = value;
    int id =
        stateList!.firstWhere((element) => element.name!.contains(value!)).id!;
    try {
      await _sharedService.getLGA(id.toString());
    } on DioError catch (e) {}
    notifyListeners();
  }

  handleSelectedLGA(String? value) {
    _selectedLGA = value;

    notifyListeners();
  }

  updateContact() {
    runBusyFuture(updateContactRequest());
  }

  updateContactRequest() async {
    var formData = {
      "phoneNumber": "string",
      "stateId": 0,
      "lgaId": 0,
      "region": "string",
      "address": "string",
      "long": "string",
      "lat": "string"
    };
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
