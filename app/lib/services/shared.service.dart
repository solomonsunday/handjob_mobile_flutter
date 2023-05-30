import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/lga.model.dart';
import 'package:handjob_mobile/models/qualification.model.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/country.model.dart';
import '../models/profession_type.model.dart';
import '../models/state.model.dart';

class SharedService with ReactiveServiceMixin {
  int _currentIndex = MainView.HOME_VIEW;

  Dio dioClient = locator<DioClient>().dio;

  SharedService() {
    listenToReactiveValues([
      states,
      lgas,
      lgasById,
      countries,
      currentIndex,
      professionTypes,
      qualifications
    ]);
  }

  int get currentIndex => _currentIndex;
  List<CustomState>? _states = [];
  List<LGA>? _lgas = [];
  List<LGA>? _lgasById = [];
  List<CustomState>? get states => _states;
  List<LGA>? get lgas => _lgas;
  List<LGA>? get lgasById => _lgasById;
  List<Country>? _countries = [];
  List<Country>? get countries => _countries;
  List<Qualification>? _qualifications = [];
  List<Qualification>? get qualifications => _qualifications;
  List<ProfessionType>? _professionTypes = [];
  List<ProfessionType>? get professionTypes => _professionTypes;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<List<Country>> getCountries() async {
    var response = await dioClient.get("/country");

    List<Map> mappedStates =
        (response.data as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponseCountryMap = mappedStates.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();

    List<Country> countries =
        newResponseCountryMap.map((x) => Country.fromJson(x)).toList();
    _countries = countries;
    notifyListeners();
    return countries;
  }

  Future<List<CustomState>> getStates() async {
    var response = await dioClient.get('/state');
    List<Map> mappedStates =
        (response.data as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponseStateMap = mappedStates.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();

    List<CustomState> states =
        newResponseStateMap.map((x) => CustomState.fromJson(x)).toList();
    _states = states;
    notifyListeners();
    return states;
  }

  Future<List<LGA>> getLGA() async {
    var response = await dioClient.get('/lga');
    List<Map> mappedStates =
        (response.data as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponseLGAMap = mappedStates.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();
    List<LGA> lgas = newResponseLGAMap.map((x) => LGA.fromJson(x)).toList();

    _lgas = lgas;
    notifyListeners();
    return lgas;
  }

  Future<List<LGA>> getLgaById(String id) async {
    var response = await dioClient.get('/lga/getbystate/$id');
    List<Map> mappedStates =
        (response.data as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponseLGAMap = mappedStates.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();
    List<LGA> lgas = newResponseLGAMap.map((x) => LGA.fromJson(x)).toList();
    _lgasById = lgas;
    notifyListeners();
    return lgas;
  }

  Future<List<Qualification>> getQualification() async {
    var response = await dioClient.get('/qualification');
    print('list qualification: ${response.data}');
    List<Map> mappedQualifications =
        (response.data["data"] as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponseQualificationMap =
        mappedQualifications.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();
    List<Qualification> qualifications = newResponseQualificationMap
        .map((x) => Qualification.fromJson(x))
        .toList();
    _qualifications = qualifications;
    notifyListeners();
    return qualifications;
  }

  Future<List<ProfessionType>> getProfessionTypes() async {
    var response = await dioClient.get(
      '/service',
    );
    List<ProfessionType> professionTypes =
        (response.data["data"] as List<dynamic>)
            .map((x) => ProfessionType.fromJson(x))
            .toList();

    _professionTypes = professionTypes;
    return professionTypes;
  }

  makePhoneCall(String phoneNumber) async {
    await launchUrl(
      Uri(
        scheme: 'tel',
        path: phoneNumber,
      ),
    );
  }

  sendEmail(String email) async {
    await launchUrl(Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': '',
      },
    ));
  }
}
