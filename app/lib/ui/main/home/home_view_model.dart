import 'dart:async';

import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/services/notification.service.dart';
import 'package:handjob_mobile/services/post.service.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/notification.model.dart' as Notif;
import '../../../models/post.model.dart';
import '../../../models/user.model.dart';
import '../../../services/authentication.service.dart';
import '../main_view_model.dart';

const String POST_BUSY = "POST_BUSY";

class HomeViewModel extends MainViewModel {
  final _navigationService = locator<NavigationService>();
  final _postService = locator<PostService>();
  final _authenticationService = locator<AuthenticationService>();
  final _notificationService = locator<NotificationService>();

  final ScrollController scrollController = ScrollController();

  User? get currentUser => _authenticationService.currentUser;
  List<Post> get posts => _postService.posts;
  bool get loadingPosts => _postService.loadingPosts;
  List<Notif.Notification>? get notifications =>
      _notificationService.notifications;

  double _offset = 0.0;
  double get offet => _offset;

  updateOffset(double value) {
    _offset = value;
    notifyListeners();
  }

  void onPostImageClick(Post post, int postIndex) {
    _navigationService.navigateToPostDetailView(
      post: post,
      postIndex: postIndex,
    );
  }

  void navigateToNotification() =>
      _navigationService.navigateToNotificationView();

  void navigateToProfile() => _navigationService.navigateToProfileView();

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _postService,
        _notificationService,
      ];

  navigateToAuthorProfile(String id) =>
      _navigationService.navigateToApplicantProfileView(applicantId: id);

  handleSearch(String value) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debouceDuration, () async {
      await searchPost(value);
    });
  }

  Future<void> searchPost(String query) async {
    // setBusyForObject(POST_BUSY, true);
    try {
      await _postService.getPosts(search: query);
    } finally {
      setBusyForObject(POST_BUSY, false);
    }
  }

  navigateToCreatePost() => setCurrentIndex(MainView.POST_VIEW);

  Timer? _debounce;

// change debouce duration accordingly
  Duration _debouceDuration = const Duration(milliseconds: 500);

  // Don't forgot to dispose it as it can cause performance issues.
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
