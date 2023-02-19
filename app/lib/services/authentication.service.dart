import 'package:dio/dio.dart';
import 'package:handjob_mobile/models/profession_type.model.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../enums/auth_type.dart';
import '../models/auth.model.dart';
import '../models/user.model.dart';
import '../utils/contants.dart';

class AuthenticationService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  AuthenticationService() {
    listenToReactiveValues([
      currentUser,
      // _currentSuperAdminUser,
    ]);
  }

  User? _currentUser;

  // final ReactiveValue<SuperAdmin?> _currentSuperAdminUser =
  //     ReactiveValue<SuperAdmin?>(null);
  User? get currentUser => _currentUser;

  Future<bool> isAuthenticated() async {
    final preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString(AUTH_TOKEN_KEY);
    String? refreshToken = preferences.getString(AUTH_REFRESH_KEY);

    if (accessToken == null || refreshToken == null) {
      return false;
    }

    DateTime? expiryDate = Jwt.getExpiryDate(accessToken);
    DateTime? refreshTokenExpiryDate =
        Jwt.getExpiryDate(accessToken); //to be removed

    bool? isAccessTokenExpired = Jwt.isExpired(accessToken);
    bool? isRefreshTokenExpired = Jwt.isExpired(refreshToken);

    if (isRefreshTokenExpired) {
      return false;
    }
    if (isAccessTokenExpired) {
      print('isAccess token has expired');
      try {
        await requestAccessTokenFromRefreshToken(refreshToken);
        return true;
      } on DioError catch (error) {
        return false;
      }
    }

    return true;
  }

  Future<Auth> requestAccessTokenFromRefreshToken(String refreshToken) async {
    final preferences = await SharedPreferences.getInstance();
    var response = await dioClient.post('/auth/token/refresh', data: {
      "type": "Mobile",
      "refreshToken": refreshToken,
    });

    print('auth response data: ${response.data}');
    Auth auth = Auth.fromJson(response.data);
    /**Persist the access token into a shared preference */
    await preferences.setString(AUTH_TOKEN_KEY, auth.accessToken.toString());
    await preferences.setString(AUTH_REFRESH_KEY, auth.refreshToken.toString());
    return auth;
  }

  Future<Auth> login(Map<String, dynamic> formData) async {
    final preferences = await SharedPreferences.getInstance();
    var response = await dioClient.post(
      '/auth/signin',
      data: formData,
    );
    // print('login detail: ${response.data}');
    Auth auth = Auth.fromJson(response.data);
    /**Persist the access token into a shared preference */
    await preferences.setString(AUTH_TOKEN_KEY, auth.accessToken.toString());
    await preferences.setString(AUTH_REFRESH_KEY, auth.refreshToken.toString());
    return auth;
  }

  Future<User> createUser(Map<String, dynamic> formData) async {
    var response = await dioClient.post(
      '/auth/signup',
      data: formData,
    );
    return User.fromJson(response.data);
  }

  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(AUTH_TOKEN_KEY);
    await preferences.remove(AUTH_REFRESH_KEY);
  }

  Future<User> getCurrentBaseUser() async {
    var response = await dioClient.get(
      '/accounts/profile/active',
    );
    User authUser = User.fromJson(response.data);
    _currentUser = authUser;
    notifyListeners();
    return authUser;
  }

  Future<Auth> verifyOTP(String code) async {
    final preferences = await SharedPreferences.getInstance();
    var response = await dioClient.get(
      '/verification/signup/$code',
    );
    // print('login detail: ${response.data}');
    Auth auth = Auth.fromJson(response.data);
    /**Persist the access token into a shared preference */
    await preferences.setString(AUTH_TOKEN_KEY, auth.accessToken.toString());
    await preferences.setString(AUTH_REFRESH_KEY, auth.refreshToken.toString());
    return auth;
  }

  Future<bool> requestOTP(Map formData) async {
    var response = await dioClient.post(
      '/verification/send-shortcode',
      data: formData,
    );
    return true;
  }

  Future<bool> requestForgotPassword(Map formData) async {
    var response = await dioClient.put(
      '/auth/send-forget-password-email',
      data: formData,
    );
    return true;
  }

  Future changePassword(Map formData) async {
    var response = await dioClient.put(
      '/auth/change-password',
      data: formData,
    );
    print('change password resp: ${response.data}');
    return true;
  }
}
