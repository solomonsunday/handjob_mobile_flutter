import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:handjob_mobile/ui/main/post/post_view.form.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.model.dart';
import '../../../services/authentication.service.dart';
import '../../../services/post.service.dart';
import '../main_view.dart';

const String NONE = 'none';
const String IMAGE = 'image';
const String VIDEO = 'video';

class PostViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _postService = locator<PostService>();
  final _navigationService = locator<NavigationService>();
  final _sharedService = locator<SharedService>();
  final _picker = ImagePicker();

  User? get currentUser => _authenticationService.currentUser;

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  String _mediaType = NONE;
  String get mediaType => _mediaType;
  List<String> get mediaTypes => [NONE, IMAGE, VIDEO];

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  File? _selectedFile;
  File? get selectedFile => _selectedFile;

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void navigateBack() => _navigationService.back();

  void handleMediaType(String? value) {
    _mediaType = value!;
    _selectedFile = null;
    print('value selectd: $value');
    notifyListeners();

    // if (_mediaType == IMAGE && selectedFile == null) {
    //   _isFormValid = false;
    //   return;
    // }
    // if (_mediaType == VIDEO && selectedFile == null) {
    //   _isFormValid = false;
    //   return;
    // }
  }

  handleImageChange() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    double size = getFileSizeInMB(file);
    if (size > 1) {
      //image file shouldn't be greater than 1mb
      setErrorMessage('Image too big, please select a file less than 1mb');
      return;
    }
    setErrorMessage(null);

    _selectedFile = file;
  }

  handleVideoChange() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    File file = File(video.path);
    double size = getFileSizeInMB(file);
    if (size > 5) {
      //video file shouldn't be greater than 5mb
      setErrorMessage('Image too big, please select a file less than 1mb');
      return;
    }
    setErrorMessage(null);

    _selectedFile = file;
  }

  @override
  void setFormStatus() {
    print('something change');
    if ((titleValue ?? "").isEmpty) {
      setTitleValidationMessage("Post title cannot be empty");
      _isFormValid = false;
      return;
    }
    if ((bodyValue ?? "").isEmpty) {
      setBodyValidationMessage("Post body is required");
      _isFormValid = false;
      return;
    }

    clearErrors();
    _isFormValid = true;
  }

  createPost() {
    runBusyFuture(createPostRequest());
  }

  createPostRequest() async {
    if (errorMessage != null) return;
    Map<String, dynamic> formData = {
      'title': titleValue,
      'body': bodyValue,
      'mediaType': mediaType == 'none' ? '' : mediaType,
    };
    if (selectedFile != null) {
      formData['files'] = selectedFile;
    }
    setBusy(true);
    try {
      await _postService.createPost(formData);
      Fluttertoast.showToast(
        msg: 'Post successfully created.',
        toastLength: Toast.LENGTH_LONG,
      );
      await _postService.getPosts();
      _sharedService.setCurrentIndex(MainView.HOME_VIEW);
    } on DioError catch (error) {
      print('Post error: ${error.message}');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}
