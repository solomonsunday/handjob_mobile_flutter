import 'dart:io';

import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/notification.model.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/meta.model.dart';
import '../models/post.model.dart';

class NotificationService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  NotificationService() {
    listenToReactiveValues([
      notifications,
      postMeta,
    ]);
  }

  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;

  Meta? _postMeta;
  Meta? get postMeta => _postMeta;

  Future<List<Notification>> getNotifications(
      {int page = 1, int limit = 10, String search = ''}) async {
    var response = await dioClient.get(
      '/notification?page=$page&take=$limit&search=$search',
    );
    _postMeta = Meta.fromJson(response.data["meta"]);
    List<Map> mappedPosts =
        (response.data["data"] as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponsePostMap = mappedPosts.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();

    List<Notification> notificationList =
        newResponsePostMap.map((x) => Notification.fromJson(x)).toList();
    _notifications = notificationList;
    notifyListeners();
    return notificationList;
  }

  Future<List<Notification>> getAccountNotifications(String accountId,
      {int page = 1, int limit = 10, String search = ''}) async {
    var response = await dioClient.get(
      '/notification/account/$accountId?page=$page&take=$limit&search=$search',
    );
    _postMeta = Meta.fromJson(response.data["meta"]);
    List<Map> mappedPosts =
        (response.data["data"] as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponsePostMap = mappedPosts.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();

    List<Notification> notificationList =
        newResponsePostMap.map((x) => Notification.fromJson(x)).toList();
    _notifications = notificationList;
    notifyListeners();
    print('account notifications: $_notifications');
    return notificationList;
  }

  Future<Notification> getNotification(String id) async {
    var response = await dioClient.get('/notification/$id');
    return Notification.fromJson(response.data);
  }

  Future<bool> updateSeenNotification(String id) async {
    var response = await dioClient.put('/notification/$id/seen');
    print('updated notification: ${response.data}');
    return true;
  }

  Future<Notification> deleteNotification(String id) async {
    var response = await dioClient.delete("/notification/$id");

    Notification notification = Notification.fromJson(response.data);
    _notifications.removeWhere((element) => element.id == notification.id);
    notifyListeners();
    return notification;
  }
}
