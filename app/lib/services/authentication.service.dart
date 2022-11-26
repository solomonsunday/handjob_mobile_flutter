import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/auth.model.dart';
import '../models/user.model.dart';
import '../utils/pos_contants.dart';

class AuthenticationService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  AuthenticationService() {
    listenToReactiveValues([
      _currentBaseUser,
      // _currentMerchantUser,
      // _currentAdminUser,
      // _currentSuperAdminUser,
    ]);
  }

  final ReactiveValue<User?> _currentBaseUser = ReactiveValue<User?>(null);
  // final ReactiveValue<Merchant?> _currentMerchantUser =
  //     ReactiveValue<Merchant?>(null);
  // final ReactiveValue<Admin?> _currentAdminUser = ReactiveValue<Admin?>(null);
  // final ReactiveValue<SuperAdmin?> _currentSuperAdminUser =
  //     ReactiveValue<SuperAdmin?>(null);
  User? get currentUser => _currentBaseUser.value;
  // Merchant? get currentMerchantUser => _currentMerchantUser.value;
  // Admin? get currentAdminUser => _currentAdminUser.value;

  Future<Auth> login(Map<String, dynamic> formData) async {
    final preferences = await SharedPreferences.getInstance();
    var response = await dioClient.post(
      '/auth/signin',
      data: formData,
    );
    Auth auth = Auth.fromJson(response.data);
    /**Persist the access token into a shared preference */
    await preferences.setString(AUTH_TOKEN_KEY, auth.accessToken.toString());
    await preferences.setString(AUTH_REFRESH_KEY, auth.refreshToken.toString());
    return auth;
  }

  Future<User> getCurrentBaseUser() async {
    var response = await dioClient.get(
      '/accounts/profile/active',
    );
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
