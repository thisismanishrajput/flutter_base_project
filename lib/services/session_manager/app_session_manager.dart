import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppSessionManager {
  static AppSessionManager instance = AppSessionManager();

  late SharedPreferences _preferences;

  Future init() async => _preferences = await SharedPreferences.getInstance();

  Future<void> savePaymentIntent(String paymentIntent) async {
    await _preferences.setString('paymentIntent', paymentIntent);
  }

  String get paymentIntent => _preferences.getString("paymentIntent") ?? "";

  Future<void> saveAdminSession(
      {required String eventId, required String timeEntered}) async {
    await _preferences.setString(eventId, timeEntered);
  }

  String? getAdminSession(String eventId) {
    return _preferences.getString(eventId);
  }

  Future<void> saveCustomToken(String authToken) async {
    if (authToken.isEmpty) {
      return;
    }

    await _preferences.setString('customToken', authToken);
  }

  String get customToken => _preferences.getString("customToken") ?? "";

  Future<void> saveStartTime(
      {required int sourceEventId,
      required List<String> subEvents,
      required int timestamp}) async {
    await _preferences.setInt(
        '$sourceEventId-${subEvents.join("•")}-startTime', timestamp);
  }

  int? getStartTime({
    required int sourceEventId,
    required List<String> subEvents,
  }) =>
      _preferences.getInt("$sourceEventId-${subEvents.join("•")}-startTime");

  Future<void> saveEndTime(
      {required int sourceEventId,
      required List<String> subEvents,
      required int timestamp}) async {
    await _preferences.setInt(
        '$sourceEventId-${subEvents.join("•")}-endTime', timestamp);
  }

  int? getEndTime({
    required int sourceEventId,
    required List<String> subEvents,
  }) =>
      _preferences.getInt("$sourceEventId-${subEvents.join("•")}-endTime");

  Future<void> removeRaceTime({
    required int sourceEventId,
    required List<String> subEvents,
  }) async {
    await _preferences
        .remove("$sourceEventId-${subEvents.join("•")}-startTime");
    await _preferences.remove("$sourceEventId-${subEvents.join("•")}-endTime");
  }

  Future<void> saveAuthToken({String authToken = ''}) async {
    if (authToken.isEmpty) {

      return;
    }
    if (kDebugMode) {
      print("saving token:$authToken");
    }
    await _preferences.setString('authToken', authToken);
  }

  String? get authToken => _preferences.getString('authToken');

  Future<void> saveRefreshToken({String refreshToken = ''}) async {
    if (refreshToken.isEmpty) {
      return;
    }

    await _preferences.setString('refreshToken', refreshToken);
  }

  String? get refreshToken => _preferences.getString('refreshToken');

  Future<void> saveAccessTokenGeneratedTime(int timestamp) async {
    await _preferences.setInt('accessTokenGeneratedTime', timestamp);
  }

  int? get accessTokenGeneratedTime =>
      _preferences.getInt('accessTokenGeneratedTime');

  Future<void> saveUserOnboardOrNot({required bool isUserOnboard}) async {
    await _preferences.setBool('isUserOnboard', isUserOnboard);
  }

  Future<bool?> getUserOnboardOrNot() async {
    return _preferences.getBool('isUserOnboard');
  }

  Future<void> saveUserProfilePhoto({required String profilePhoto}) async {
    await _preferences.setString('profilePhoto', profilePhoto);
  }

  String get profilePhoto => _preferences.getString("profilePhoto") ?? "";

  Future<void> saveUserId({String userId = ''}) async {
    await _preferences.setString('userId', userId);
  }

  String? get userId => _preferences.getString('userId');

  Future<void> saveUserRole({String role = ''}) async {
    await _preferences.setString('userRole', role);
  }

  String? get userRole => _preferences.getString('userRole');

  Future<void> switchUserRole({required bool isUserSwitched}) async {
    await _preferences.setBool('isUserSwitched', isUserSwitched);
  }

  bool? get isUserSwitched => _preferences.getBool('isUserSwitched');



  Future<String?> getUserLocation() async {
    return _preferences.getString('location');
  }

  Future<void> saveFCMToken({String fcmToken = ''}) async {
    if (fcmToken.isEmpty) {
      return;
    }

    await _preferences.setString('fcmToken', fcmToken);
  }

  String? getFCMToken() {
    return _preferences.getString('fcmToken');
  }

  Future<void> saveUsername({String username = ''}) async {
    if (username.isEmpty) {
      return;
    }

    await _preferences.setString('username', username);
  }

  String? get userName => _preferences.getString('username');

  Future<void> saveFirstName(String firstname) async {
    if (firstname.isEmpty) {
      return;
    }
    await _preferences.setString("firstname", firstname);
  }

  String get firstName => _preferences.getString("firstname") ?? "";

  Future<void> saveLastName({String lastname = ''}) async {
    if (lastname.isEmpty) {
      return;
    }

    await _preferences.setString('lastname', lastname);
  }

  String get lastname => _preferences.getString("lastname") ?? "";

  Future<void> saveEmail({String email = ''}) async {
    if (email.isEmpty) {
      return;
    }

    await _preferences.setString('email', email);
  }

  String get email => _preferences.getString("email") ?? "";



  String get isComeFrom => _preferences.getString("isComeFrom") ?? '';

  Future<void> saveMobileNumber({String mobileNumber = ''}) async {
    if (mobileNumber.isEmpty) {
      return;
    }

    await _preferences.setString('mobileNumber', mobileNumber);
  }

  String get mobileNumber => _preferences.getString("mobileNumber") ?? "";

  Future<void> saveUserAge({String userage = ''}) async {
    if (userage.isEmpty) {
      return;
    }

    await _preferences.setString('userage', userage);
  }

  String get userAge => _preferences.getString("userage") ?? "";

  Future<void> saveUserGender({String saveUserGender = ''}) async {
    if (saveUserGender.isEmpty) {
      return;
    }

    await _preferences.setString('saveUserGender', saveUserGender);
  }

  String get gender => _preferences.getString("saveUserGender") ?? "";

  Future<void> saveIsBackgroundSessionEnabled(
      {required bool isBackgroundSessionEnabled}) async {
    await _preferences.setBool(
        'isBackgroundSessionEnabled', isBackgroundSessionEnabled);
  }

  bool get isBackgroundSessionEnabled =>
      _preferences.getBool('isBackgroundSessionEnabled') ?? false;

  Future<void> clearPref([bool isAccountDeleted = false]) async {
    final token = AppSessionManager.instance.getFCMToken();
    await _preferences.clear();
    if (token != null) {
      saveFCMToken(fcmToken: token);
    }
  }
}
