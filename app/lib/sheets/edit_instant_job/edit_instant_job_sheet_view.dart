import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:handjob_mobile/models/instant_job.model.dart';
import 'package:handjob_mobile/sheets/edit_instant_job/edit_instant_job_sheet_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../models/suggestion.model.dart';
import '../../utils/contants.dart';
import '../../utils/helpers.dart';

class EditInstantJobSheetView extends StatelessWidget {
  const EditInstantJobSheetView({
    super.key,
    this.request,
    this.completer,
  });

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  static String _displayStringForOption(Suggestion option) =>
      option.description;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditInstantJobSheetViewModel>.reactive(
      viewModelBuilder: () => EditInstantJobSheetViewModel(),
      onViewModelReady: (model) async {
        // await model.fetchProfessionTypes();
        if (request?.data != null) {
          InstantJob job = request?.data as InstantJob;

          model.handleChangeIsNow(job.now ?? false);
          //  DateFormat formatter = DateFormat('dd-MMM-yyyy');
          print('instant job edit: ${job.toJson()}');
          if (job.startDate != null) {
            model.handleStartDate(
                fromDateTimeToDefaultFormat(fromIsoToDateTime(job.startDate!)));
          }
          if (job.endDate != null) {
            model.handleEndDate(
                fromDateTimeToDefaultFormat(fromIsoToDateTime(job.endDate!)));
          }
          model.handleSelectedProfession(job.service ?? "");
          print('profession: ${model.selectedProfession}');
          model.updateMeetupLocation(job.meetupLocation ?? "");
          model.updateLocation(job.address ?? "");
          model.serviceLocationController.text = job.address ?? "";
          model.serviceLocationValue =
              TextEditingValue(text: job.address ?? "");
          model.meetupLocationController.text = job.meetupLocation ?? "";

          if (job.address != null || job.address != "") {
            try {
              await model.handleSuggestion(job.address ?? "");
              print('suggestion: ${model.suggestions[0].toJson()}');

              await model.updateCoordinate(model.suggestions[0].placeId);
            } catch (e) {}
          }
          // model.setSelectedState(request?.data["state"]);
          // model.setSelectedLGA(job.);
          model.updateDescription(job.description ?? "");
          model.updateId(job.id);
        }
      },
      builder: (context, model, child) {
        return BottomSheetContainer(
          padding: EdgeInsets.all(AppPadding.p8),
          onClose: () => completer!(SheetResponse(confirmed: false)),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: AppPadding.p16,
                  right: AppPadding.p16,
                  top: AppPadding.p16,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.kWhiteColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultDropDownField(
                      label: 'Type of service needed',
                      hint: 'choose service',
                      value: model.selectedProfession,
                      dropdownItems: model.professions,
                      onChanged: model.handleSelectedProfession,
                      requiredField: true,
                      buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorManager.kDarkColor,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      buttonWidth: MediaQuery.of(context).size.width,
                      dropdownWidth: MediaQuery.of(context).size.width,
                      buttonHeight: AppSize.s48,
                    ),
                    if (model.busy(PROFESSION_TYPES))
                      const LinearProgressIndicator(
                        color: ColorManager.kPrimaryColor,
                      ),
                    const SizedBox(height: AppSize.s12),
                    !model.editServiceLocation
                        ? InputField(
                            controller: model.serviceLocationController,
                            readOnly: true,
                            label: 'Service Location',
                            requiredField: true,
                            onTap: model.handleEditServiceLocation)
                        : Autocomplete<Suggestion>(
                            initialValue: TextEditingValue(
                                text: model.serviceLocationController.text),
                            displayStringForOption: _displayStringForOption,
                            optionsBuilder:
                                (TextEditingValue textEditingValue) async {
                              print('option builder: ${textEditingValue.text}');
                              if (textEditingValue.text == '') {
                                return const Iterable<Suggestion>.empty();
                              }
                              await model
                                  .handleSuggestion(textEditingValue.text);

                              return model.suggestions
                                  .where((Suggestion option) {
                                return option.description
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase());
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
                                focusNode, onFieldSubmitted) {
                              // WidgetsBinding.instance?.addPostFrameCallback((_) {
                              //   // <--- this part
                              //   var initialValue =
                              //       model.serviceLocationController.text;

                              //   textEditingController.text = initialValue;
                              // });
                              return InputField(
                                label: 'Service Location',
                                requiredField: true,
                                controller: textEditingController,
                                focusnode: focusNode,
                                onTap: onFieldSubmitted,
                                fillColor: ColorManager.kWhiteColor,
                              );
                            }),
                    SizedBox(height: AppSize.s12),
                    Row(
                      children: [
                        Expanded(
                          child: !model.editMeetupLocation
                              ? InputField(
                                  controller: model.meetupLocationController,
                                  readOnly: true,
                                  label:
                                      'Meet up location (if different from service location)',
                                  onTap: model.handleEditMeetupLocation,
                                )
                              : Autocomplete<Suggestion>(
                                  initialValue: TextEditingValue(
                                      text:
                                          model.meetupLocationController.text),
                                  displayStringForOption:
                                      _displayStringForOption,
                                  optionsBuilder: (TextEditingValue
                                      textEditingValue) async {
                                    if (textEditingValue.text == '') {
                                      return const Iterable<Suggestion>.empty();
                                    }
                                    await model.handleSuggestion(
                                        textEditingValue.text);

                                    return model.suggestions
                                        .where((Suggestion option) {
                                      return option.description
                                          .toLowerCase()
                                          .contains(textEditingValue.text
                                              .toLowerCase());
                                    });
                                  },
                                  onSelected: (Suggestion selection) {
                                    debugPrint(
                                        'You just selected ${_displayStringForOption(selection)}');
                                    model.updateMeetupLocation(
                                        _displayStringForOption(selection));
                                  },
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode,
                                      onFieldSubmitted) {
                                    // WidgetsBinding.instance
                                    //     ?.addPostFrameCallback((_) {
                                    //   // <--- this part
                                    //   var initialValue =
                                    //       model.meetupLocationController.text;

                                    //   textEditingController.text = initialValue;
                                    // });
                                    return InputField(
                                      label:
                                          'Meet up location (if different from service location)',
                                      controller: textEditingController,
                                      focusnode: focusNode,
                                      onTap: onFieldSubmitted,
                                      fillColor: ColorManager.kWhiteColor,
                                    );
                                  }),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultDropDownField(
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonHeight: 50,
                            hint: 'Select',
                            label: 'State',
                            requiredField: true,
                            value: model.selectedStateValue,
                            dropdownItems:
                                (model.stateNames).map((e) => e!).toList(),
                            onChanged: (String? value) {
                              model.setSelectedState(value);
                            },
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              border: Border.all(
                                width: 1,
                                color: ColorManager.kDarkColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s12),
                        Expanded(
                          child: DefaultDropDownField(
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonHeight: 50,
                            hint: 'Select',
                            label: 'LGA',
                            requiredField: true,
                            value: model.selectedLgaValue,
                            dropdownItems:
                                model.lgaNames?.map((e) => e).toList() ?? [],
                            onChanged: (String? value) {
                              model.setSelectedLGA(value);
                            },
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              border: Border.all(
                                width: 1,
                                color: ColorManager.kDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Start date',
                                    style: getRegularStyle(
                                      color: ColorManager.kDarkColor,
                                    ),
                                  ),
                                  Text(
                                    ' * ',
                                    style: getRegularStyle(
                                      color: ColorManager.kRed,
                                    ),
                                  ),
                                  Text(
                                    '(',
                                    style: getRegularStyle(
                                      color: ColorManager.kDarkColor,
                                    ),
                                  ),
                                  DefaultCheckBox(
                                    value: model.isNow,
                                    onChanged: model.handleChangeIsNow,
                                    richText: Text(
                                      'NOW',
                                      textAlign: TextAlign.center,
                                      style: getBoldStyle(
                                        color: ColorManager.kDarkColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ')',
                                    style: getRegularStyle(
                                      color: ColorManager.kDarkColor,
                                    ),
                                  ),
                                ],
                              ),
                              DatePicker(
                                // label: 'Start date *',
                                controller: model.startDateController,
                                onSelected: model.handleStartDate,
                                initialDate: model.isNow
                                    ? toDefaultDtFormat(
                                        model.startDateController.text)
                                    : DateTime.now(),
                                firstDate: model.isNow
                                    ? DateTime.now()
                                    : model.startDateController.text.isNotEmpty
                                        ? toDefaultDtFormat(
                                            model.startDateController.text)
                                        : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppPadding.p10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'End Date',
                                    style: getRegularStyle(
                                      color: ColorManager.kDarkColor,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: getRegularStyle(
                                      color: ColorManager.kRed,
                                    ),
                                  ),
                                ],
                              ),
                              DatePicker(
                                // label: 'End Date *',
                                // requiredField: true,
                                controller: model.endDateController,
                                onSelected: model.handleEndDate,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s8),
                    Row(
                      children: [
                        Expanded(
                          child: Textarea(
                            label: 'Describe service needed',
                            requiredField: true,
                            controller: model.describeServiceController,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              borderSide:
                                  BorderSide(color: ColorManager.kDarkColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              borderSide:
                                  BorderSide(color: ColorManager.kNavDarkColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              borderSide:
                                  BorderSide(color: ColorManager.kNavDarkColor),
                            ),
                            fillColor: ColorManager.kWhiteColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s40),
                    if (model.errorMessage.isNotEmpty)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(AppSize.s8),
                        margin: EdgeInsets.only(bottom: AppSize.s12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: ColorManager.kRed,
                          ),
                        ),
                        child: Text(
                          model.errorMessage,
                          style: getMediumStyle(
                            color: ColorManager.kRed,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    if (model.hasError)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(AppSize.s8),
                        margin: EdgeInsets.only(bottom: AppSize.s12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: ColorManager.kRed,
                          ),
                        ),
                        child: Text(
                          '${model.modelError}',
                          style: getMediumStyle(
                            color: ColorManager.kRed,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    DefaultButton(
                      onPressed: model.isBusy
                          ? () {}
                          : () => model.updateInstantService(completer),
                      title: 'Update',
                      busy: model.isBusy,
                      disabled: model.isBusy,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
