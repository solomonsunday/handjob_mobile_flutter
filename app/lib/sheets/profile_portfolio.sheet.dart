import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/services/account.service.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../models/user.model.dart';
import '../ui/profile/components/profile_portfolio_gallery.dart';

class ProfilePortfolioSheet extends StatelessWidget {
  const ProfilePortfolioSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePortfolioSheetViewModel>.reactive(
        viewModelBuilder: () => ProfilePortfolioSheetViewModel(),
        builder: (context, model, child) {
          return BottomSheetContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p24,
              vertical: AppPadding.p10,
            ),
            onClose: () => completer!(SheetResponse(confirmed: false)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.photo_library_outlined,
                        color: ColorManager.kSecondaryColor,
                      ),
                      SizedBox(width: AppSize.s12),
                      Text('Portfolio'),
                    ],
                  ),
                  const SizedBox(height: AppSize.s24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected files'),
                      const SizedBox(height: AppSize.s12),
                      Column(
                        children: (model.images)
                            .map((e) => SelectedFileWidget(
                                  file: File(e.path),
                                  onDelete: (file) {
                                    model.deleteFile(file);
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s20),
                  GestureDetector(
                    onTap: model.openFileDialog,
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: ColorManager.kGrey,
                      size: AppSize.s32,
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ProfilePortfolioGallery(
                        currentUser: model.currentUser!,
                      ),
                      const SizedBox(height: AppSize.s8),
                    ],
                  ),
                  const SizedBox(height: AppSize.s24),
                  DefaultButton(
                    onPressed: model.isBusy ? () {} : model.uploadPortfolios,
                    title: 'Save changes',
                    busy: model.isBusy,
                    disabled: model.isBusy,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class SelectedFileWidget extends StatelessWidget {
  const SelectedFileWidget({
    Key? key,
    required this.file,
    required this.onDelete,
  }) : super(key: key);

  final File file;
  final Function(File)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: DottedBorder(
        color: ColorManager.kGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: AppSize.s40,
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSize.s24),
              Expanded(child: Text(file.path)),
              GestureDetector(
                  onTap: () => onDelete!(file),
                  child: const Icon(Icons.close, size: AppSize.s24)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePortfolioSheetViewModel extends BaseViewModel {
  final ImagePicker _picker = ImagePicker();
  final _accountService = locator<AccountService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  User? get currentUser => _authenticationService.currentUser;

  final List<XFile> _images = [];
  List<XFile> get images => _images;

  Future<void> openFileDialog() async {
    List<XFile>? list = await _picker.pickMultiImage();
    _images.addAll([...list]);
    notifyListeners();
  }

  void deleteFile(File file) {
    print('delete file');
    int index = _images.indexWhere(
      (element) => element.path == file.path,
    );
    _images.removeAt(index);
    notifyListeners();
  }

  uploadPortfolios() {
    runBusyFuture(uploadPortfoliosRequest());
  }

  Future uploadPortfoliosRequest() async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Do you want to proceed ?",
    );
    if (!response!.confirmed) return;

    if (images.isEmpty) {
      print('no images file');
      return;
    }
    try {
      await _accountService.uploadPortfolio(File(images[0].path));
      await _accountService.uploadPortfolios(
        images.map((e) => File(e.path)).toList(),
      );
      await _authenticationService.getCurrentBaseUser();
    } on DioError catch (e) {
      print('error: ${e.response!.data}');
      _dialogService.showDialog(
        title: "An error occured",
        description: '${e.response!.data["message"]}',
      );
    }
  }
}
