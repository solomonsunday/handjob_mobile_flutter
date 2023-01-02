import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../enums/auth_type.dart';
import '../models/auth.model.dart';
import '../models/user.model.dart';
import '../utils/pos_contants.dart';

class AuthenticationService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  AuthenticationService() {
    listenToReactiveValues([
      currentUser,
      // _currentAdminUser,
      // _currentSuperAdminUser,
    ]);
  }

  final ReactiveValue<User?> _currentBaseUser = ReactiveValue<User?>(null);
  // final ReactiveValue<Admin?> _currentAdminUser = ReactiveValue<Admin?>(null);
  // final ReactiveValue<SuperAdmin?> _currentSuperAdminUser =
  //     ReactiveValue<SuperAdmin?>(null);
  User? get currentUser => _currentBaseUser.value;
  // Admin? get currentAdminUser => _currentAdminUser.value;

  Future<bool> isAuthenticated() async {
    final preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString(AUTH_TOKEN_KEY);
    String? refreshToken = preferences.getString(AUTH_REFRESH_KEY);
    print('refresh token: $refreshToken');
    if (accessToken == null || refreshToken == null) {
      return false;
    }

    DateTime? expiryDate = Jwt.getExpiryDate(accessToken);
    DateTime? refreshTokenExpiryDate =
        Jwt.getExpiryDate(accessToken); //to be removed
    print(
        'refresh token expiry date: $refreshTokenExpiryDate, expiry date: $expiryDate');
    bool? isAccessTokenExpired = Jwt.isExpired(accessToken);
    bool? isRefreshTokenExpired = Jwt.isExpired(refreshToken);
    print(
        'Access token and Refresh token expired: $isAccessTokenExpired, refresh $isRefreshTokenExpired');
    if (isRefreshTokenExpired) {
      return false;
    }
    if (isAccessTokenExpired) {
      try {
        await this.requestAccessTokenFromRefreshToken(refreshToken);
        return true;
      } on DioError catch (error) {
        return false;
      }
    }

    return true;
  }

  requestAccessTokenFromRefreshToken(String refreshToken) async {
    var response = await dioClient.post('/auth/token/refresh', data: {
      "type": "Mobile",
      "refreshToken": refreshToken,
    });
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
    print('user to json: ${response.data}');
    User authUser = User.fromJson(response.data);
    _currentBaseUser.value = authUser;
    return authUser;
  }

  // Future<Merchant> getCurrentMerchantUser() async {
  //   var response = await dioClient.get(
  //     '/merchant/profile',
  //   );
  //   Merchant merchant = Merchant.fromJson(response.data);
  //   _currentMerchantUser.value = merchant;
  //   return merchant;
  // }

  // Future<Admin> getCurrentAdminUser() async {
  //   var response = await dioClient.get(
  //     '/admin/profile',
  //   );
  //   Admin authUser = Admin.fromJson(response.data);
  //   _currentAdminUser.value = authUser;
  //   return authUser;
  // }

  // Future<SuperAdmin> getCurrentUser() async {
  //   try {
  //     var response = await dioClient.dio.get(
  //       '/user/me',
  //     );
  //     AuthUser authUser = AuthUser.fromJson(response.data);
  //     setCurrentUser(authUser);
  //     return authUser;
  //   } on DioError catch (err) {
  //     throw err;
  //   }
  // }
}
