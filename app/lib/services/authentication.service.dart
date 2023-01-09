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
      professionTypes,
      // _currentSuperAdminUser,
    ]);
  }

  User? _currentUser;
  final ReactiveValue<List<ProfessionType>?> _professionTypes =
      ReactiveValue<List<ProfessionType>?>([]);
  // final ReactiveValue<SuperAdmin?> _currentSuperAdminUser =
  //     ReactiveValue<SuperAdmin?>(null);
  User? get currentUser => _currentUser;
  List<ProfessionType>? get professionTypes => _professionTypes.value;

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
    print('user to json: ${response.data}');
    User authUser = User.fromJson(response.data);
    _currentUser = authUser;
    notifyListeners();
    return authUser;
  }

  Future<List<ProfessionType>> getProfessionTypes() async {
    var response = await dioClient.get(
      '/service',
    );
    List<ProfessionType> professionTypes =
        (response.data["data"] as List<dynamic>)
            .map((x) => ProfessionType.fromJson(x))
            .toList();

    _professionTypes.value = professionTypes;
    return professionTypes;
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
    print('response data: ${response.data}');
    return true;
  }

  Future<bool> requestForgotPassword(Map formData) async {
    var response = await dioClient.put(
      '/auth/send-forget-password-email',
      data: formData,
    );
    print('response data: ${response.data}');
    return true;
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
