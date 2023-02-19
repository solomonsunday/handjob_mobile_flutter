import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/services/post.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/post.model.dart';
import '../../../models/user.model.dart';
import '../../../services/authentication.service.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _postService = locator<PostService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;
  List<Post> get posts => _postService.posts;

  void onPostImageClick(Post post) {
    _navigationService.navigateTo(Routes.postDetailView,
        arguments: PostDetailViewArguments(post: post));
  }

  void navigateToNotification() {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_postService];
}
