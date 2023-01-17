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
  List<State>? _states = [];
  List<LGA>? _lgas = [];
  List<State>? get states => _states;
  List<LGA>? get lgas => _lgas;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<List<State>> getStates() async {
    var response = await dioClient.get('/state');

    List<State> states = (response.data["data"] as List<dynamic>)
        .map((x) => State.fromJson(x))
        .toList();
    _states = states;
    notifyListeners();
    return states;
  }

  Future<List<LGA>> getLGA(String stateId) async {
    var response = await dioClient.get('/lga/getbystate/$stateId');
    List<LGA> lgas = (response.data["data"] as List<dynamic>)
        .map((x) => LGA.fromJson(x))
        .toList();
    _lgas = lgas;
    notifyListeners();
    return lgas;
  }
}
