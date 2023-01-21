import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/lga.model.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/state.model.dart';

class SharedService with ReactiveServiceMixin {
  int _currentIndex = MainView.HOME_VIEW;

  Dio dioClient = locator<DioClient>().dio;

  SharedService() {
    listenToReactiveValues([]);
  }

  int get currentIndex => _currentIndex;
  List<CustomState>? _states = [];
  List<LGA>? _lgas = [];
  List<CustomState>? get states => _states;
  List<LGA>? get lgas => _lgas;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<List<CustomState>> getStates() async {
    var response = await dioClient.get('/state');
    print('response.data["data"]: ${response.data["data"]}');
    List<CustomState> states =
        (response.data["data"] as List<Map<String, dynamic>>)
            .map((x) => CustomState.fromJson(x))
            .toList();
    _states = states;
    notifyListeners();
    return states;
  }

  Future<List<LGA>> getLGA(String stateId) async {
    var response = await dioClient.get('/lga/getbystate/$stateId');
    List<LGA> lgas = (response.data["data"] as List<Map<String, dynamic>>)
        .map((x) => LGA.fromJson(x))
        .toList();
    _lgas = lgas;
    notifyListeners();
    return lgas;
  }
}
