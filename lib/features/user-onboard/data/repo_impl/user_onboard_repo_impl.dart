import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_base_project/features/user-onboard/data/model/login_response_model.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';

import '../../../../api_integration/api_constants.dart';
import '../../../../api_integration/dio_client.dart';
import '../../../../services/service_locator.dart';
import '../../domain/repo/user_onboard_repo.dart';

class UserOnboardRepoImpl extends UserOnboardRepo {
  final DioClient _dio = serviceLocator<DioClient>();

  @override
  Future<Either<String, UserData?>> loginWithPhone(String phone) async {
    try {
      // Trigger Firebase phone authentication
      final verificationResult = await _triggerPhoneAuth(phone);

      return verificationResult.fold(
            (error) => Left(error),
            (firebaseUser) async {
          // On Firebase success, proceed with your server login
          Map<String, dynamic> req = {
            "phone": phone,
            "device_type": "android",
            "device_token": "sample_device_token",
            "api_token": "sample_api_token",
            "token": "sample_token",
            "username": "manish"
          };

          final result = await _dio.post(APIEndPoints.phoneLogin, body: req);

          return result.fold((l) => Left(l), (data) {
              try {
                LoginData response = LoginData.fromJson(data);
                if (response.status) {
                  return Right(response.data?[0]);
                } else {
                  return Left(response.message ?? kSomethingWentWrong);
                }
              } catch (e) {
                debugPrint(e.toString());
                return Left(e.toString());
              }
            },
          );
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> _triggerPhoneAuth(String phoneNumber) async {
    final completer = Completer<Either<String, User>>();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto sign-in
          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          completer.complete(Right(userCredential.user!));
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.complete(Left(e.message ?? "Phone verification failed"));
        },
        codeSent: (String verificationId, int? resendToken) {
          // Notify the UI layer to navigate to OTP screen
          completer.complete(Left("OTP_SENT:$verificationId"));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Notify UI about timeout
          completer.complete(Left("TIMEOUT:$verificationId"));
        },
      );
    } catch (e) {
      completer.complete(Left("Error during phone auth: $e"));
    }

    return completer.future;
  }

  @override
  Future<Either<String, UserCredential>> verifyOtp(String verificationId, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return Right(userCredential);
    } catch (e) {
      return const Left("Invalid OTP! Please try again.");
    }
  }
}
