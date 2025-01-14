import 'package:flutter_base_project/features/user-onboard/data/model/login_response_model.dart';

enum StateUpdateStatus { none, updating, success, failed }

class UserOnboardState {
  final StateUpdateStatus phoneLoginStatus;
  final StateUpdateStatus phoneVerificationStatus;
  final UserData? userLoginData;
  final String? phoneNumber;
  final String? verificationID;
  final String firstName;
  final String lastName;
  final String errorMessage;

  UserOnboardState({
    this.phoneLoginStatus = StateUpdateStatus.none,
    this.phoneVerificationStatus = StateUpdateStatus.none,
    this.userLoginData,
    this.phoneNumber,
    this.verificationID,
    this.firstName = '',
    this.lastName = '',
    this.errorMessage = '',
  });

  UserOnboardState copyWith({
    StateUpdateStatus? phoneLoginStatus,
    StateUpdateStatus? otpVerificationStatus,
    UserData? userLoginData,
    String? phoneNumber,
    String? verificationID,
    String? firstName,
    String? lastName,
    String? errorMessage,
  }) {
    return UserOnboardState(
      phoneLoginStatus: phoneLoginStatus ?? this.phoneLoginStatus,
      phoneVerificationStatus: otpVerificationStatus ?? phoneVerificationStatus,
      userLoginData: userLoginData ?? this.userLoginData,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationID: verificationID ?? this.verificationID,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
