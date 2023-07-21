import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../models/profession_type.model.dart';
import '../models/user.model.dart';
import '../services/account.service.dart';
import '../utils/contants.dart';

class ProfileServiceSheet extends StatelessWidget {
  const ProfileServiceSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileServiceSheetViewModel>.reactive(
      viewModelBuilder: () => ProfileServiceSheetViewModel(),
      builder: (context, model, child) {
        return BottomSheetContainer(
          onClose: () => completer!(SheetResponse(confirmed: false)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tag,
                    color: ColorManager.kSecondaryColor,
                  ),
                  SizedBox(width: AppSize.s12),
                  Text('Services'),
                ],
              ),
              const SizedBox(height: AppSize.s24),
              const Text('Add up to five services'),
              const SizedBox(height: AppSize.s24),
              DefaultDropDownField(
                hint: 'Select service',
                value: model.selectedProfession,
                dropdownItems: model.professions,
                onChanged: model.handleSelectedService,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonDecoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: ColorManager.kGrey,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                dropdownWidth: MediaQuery.of(context).size.width,
              ),
              if (model.busy(PROFESSION_TYPES))
                const LinearProgressIndicator(
                  color: ColorManager.kPrimaryColor,
                ),
              Wrap(
                spacing: 2,
                runSpacing: -10,
                runAlignment: WrapAlignment.start,
                clipBehavior: Clip.none,
                children: (model.services ?? [])
                    .map(
                      (service) => Chip(
                        label: Text(
                          service,
                          style: getRegularStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s12,
                          ),
                        ),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: AppSize.s16,
                        ),
                        onDeleted: () {
                          print('delete $service');
                          model.removeService(service);
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppSize.s24),
              DefaultButton(
                onPressed: model.services!.isEmpty
                    ? () {}
                    : () => model.updateServices(completer),
                title: 'Save',
                busy: model.isBusy,
                busyColor: ColorManager.kWhiteColor,
                disabled: model.services!.isEmpty,
              )
            ],
          ),
        );
      },
    );
  }
}

class ProfileServiceSheetViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _accountService = locator<AccountService>();
  final _sharedService = locator<SharedService>();

  String? _selectedProfession;
  List<ProfessionType>? get professionTypes => _sharedService.professionTypes;

  String? get selectedProfession => _selectedProfession;
  List<String> get professions {
    if (professionTypes == null) {
      return [];
    }
    return professionTypes!.map((e) => e.name).toList();
  }

  User? get currentUser => _authenticationService.currentUser;
  List<String>? get services => currentUser?.services;

  void handleSelectedService(String? value) {
    // _selectedProfession = value;
    if ((services ?? []).length >= 5) return;

    if (services!.contains(value)) return;
    // _selectedServices = [..._selectedServices, value!];
    (services ?? []).add(value!);

    notifyListeners();
  }

  updateServices(Function(SheetResponse<dynamic>)? completer) {
    runBusyFuture(updateServicesRequest(completer));
  }

  updateServicesRequest(completer) async {
    if (services!.isEmpty) return;
    setBusy(true);
    try {
      var formData = {"services": services};
      // print('form data: $formData');
      await _accountService.updateServices(formData);
      await _authenticationService.getCurrentBaseUser();
      completer!(SheetResponse(
        confirmed: true,
      ));
    } on DioError catch (error) {
      throw HttpException(error.message);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void removeService(String service) {
    services!.remove(service);
    notifyListeners();
  }
}
