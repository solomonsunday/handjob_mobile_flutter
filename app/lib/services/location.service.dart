import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stacked/stacked_annotations.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/place.model.dart';
import '../models/suggestion.model.dart';

class LocationService {
  Dio dioClient = locator<DioClient>().dio;

  static const String androidKey = 'AIzaSyDxaC_Q4OI6Kx84VPT4W4k6N6FYLEVfcw0';
  static const String iosKey = 'AIzaSyDxaC_Q4OI6Kx84VPT4W4k6N6FYLEVfcw0';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  final String? sessionToken;
  LocationService(@factoryParam this.sessionToken);

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ng&key=$apiKey&sessiontoken=$sessionToken';
    final response = await dioClient.get(request);

    if (response.statusCode == 200) {
      final result = response.data;
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>(
              (p) => Suggestion(
                placeId: p['place_id'],
                description: p['description'],
              ),
            )
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      print('error message location service: ${result["error_message"]}');
      // throw result['error_message'];
      throw 'location service error';
    } else {
      throw 'Failed to fetch suggestion';
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component,geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await dioClient.get(request);

    if (response.statusCode == 200) {
      final result = response.data;
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        final lat = result['result']['geometry']['location']['lat'];
        final lon = result['result']['geometry']['location']['lng'];
        // build result
        final place = Place();
        place.lat = lat;
        place.lon = lon;
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
