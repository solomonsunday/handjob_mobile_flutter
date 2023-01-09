import 'package:dio/dio.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';

class SharedService with ReactiveServiceMixin {
  int _currentIndex = MainView.HOME_VIEW;

  Dio dioClient = locator<DioClient>().dio;

  SharedService() {
    listenToReactiveValues([]);
  }

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  getStates() async {
    var response = await dioClient.get('state');

    // return
  }

  getLGA(String stateId) {}
}
