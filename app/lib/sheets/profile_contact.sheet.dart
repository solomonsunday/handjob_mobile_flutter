import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class ProfileContactSheet extends StatelessWidget {
  const ProfileContactSheet({
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
        builder: (context, model, child) {
          return BottomSheetContainer(
            onClose: () => completer!(SheetResponse(confirmed: false)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: ColorManager.kSecondaryColor,
                    ),
                    SizedBox(width: AppSize.s12),
                    Text('Contact Information'),
                  ],
                ),
                SizedBox(height: AppSize.s24),
                InputField(
                  label: 'Email address',
                  hintText: 'johndemola@gmail.com',
                  fillColor: ColorManager.kWhiteColor,
                ),
                SizedBox(height: AppSize.s12),
                InputField(
                  label: 'Phone number',
                  hintText: 'Enter phone number',
                  fillColor: ColorManager.kWhiteColor,
                ),
                SizedBox(height: AppSize.s12),
                Column(
                  children: [
                    DefaultDropDownField(
                      label: 'State',
                      hint: 'Enter',
                      dropdownItems: [],
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
                      dropdownItems: [],
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

class ProfileContactSheetViewModel extends BaseViewModel {
  String? _selectedState;
  String? _selectedLGA;

  String? get selectedState => _selectedState;
  String? get selectedLGA => _selectedLGA;

  handleSelectedState(String? value) {}

  handleSelectedLGA(String? value) {}
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
}
