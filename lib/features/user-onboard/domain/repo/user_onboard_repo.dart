import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_base_project/features/user-onboard/data/model/login_response_model.dart';


abstract class UserOnboardRepo {
  Future<Either<String, UserData?>> loginWithPhone(String phone);
  Future<Either<String, UserCredential>> verifyOtp(String verificationId, String otp);
}

