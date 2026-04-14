import 'package:clean_arch_base/src/core/constants/network_headers.dart';
import 'package:clean_arch_base/src/core/network/auth_session_manager.dart';
import 'package:clean_arch_base/src/core/storage/shared_pref_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthSessionManager', () {
    late SharedPrefService sharedPrefService;
    late Dio dio;
    late AuthSessionManager sessionManager;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPrefService = SharedPrefService(
        sharedPreferences: sharedPreferences,
      );
      dio = Dio();
      sessionManager = AuthSessionManager(
        sharedPrefService: sharedPrefService,
        dio: dio,
      );
    });

    test(
      'setAccessToken persists token, updates header, and notifies',
      () async {
        var notificationCount = 0;
        sessionManager.addListener(() {
          notificationCount++;
        });

        await sessionManager.setAccessToken('abc123');

        expect(sharedPrefService.getAccessToken(), 'abc123');
        expect(
          dio.options.headers[NetworkHeaders.authorization],
          '${NetworkHeaders.bearerPrefix} abc123',
        );
        expect(sessionManager.isLoggedIn, isTrue);
        expect(notificationCount, 1);
      },
    );

    test('logout clears token, removes header, and notifies', () async {
      await sessionManager.setAccessToken('abc123');
      var notificationCount = 0;
      sessionManager.addListener(() {
        notificationCount++;
      });

      await sessionManager.logout();

      expect(sharedPrefService.getAccessToken(), isNull);
      expect(
        dio.options.headers.containsKey(NetworkHeaders.authorization),
        isFalse,
      );
      expect(sessionManager.isLoggedIn, isFalse);
      expect(notificationCount, 1);
    });

    test(
      'hydrateAccessTokenToHeader restores an existing token into dio',
      () async {
        await sharedPrefService.saveAccessToken('persisted-token');

        sessionManager.hydrateAccessTokenToHeader();

        expect(
          dio.options.headers[NetworkHeaders.authorization],
          '${NetworkHeaders.bearerPrefix} persisted-token',
        );
        expect(sessionManager.isLoggedIn, isTrue);
      },
    );
  });
}
