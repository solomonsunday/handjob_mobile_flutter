import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:stacked/stacked.dart';

class SharedService with ReactiveServiceMixin {
  int _currentIndex = MainView.HOME_VIEW;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
