
abstract class UserOnboardEvent {
  const UserOnboardEvent();
}
class LoginEvent extends UserOnboardEvent {
  final String phoneNumber;
  const LoginEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends UserOnboardEvent {
  final String? otp;
  final String? verificationId;
  const VerifyOtpEvent({  this.otp,this.verificationId});
}



