import 'package:handjob_mobile/services/video-call.service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';

class OngoingVideoCallViewModel extends ReactiveViewModel {
  final _videoCallService = locator<VideoCallService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
