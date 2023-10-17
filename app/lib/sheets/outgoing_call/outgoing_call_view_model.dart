import 'package:stacked/stacked.dart';

class OutgoingCallViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];

  bool _micOn = true;
  bool get micOn => _micOn;

  void toggleMic() {
    _micOn = !_micOn;
    notifyListeners();
  }
}
